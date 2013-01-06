# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/eagle/eagle-5.11.0.ebuild,v 1.4 2012/09/24 00:47:51 vapier Exp $

EAPI="1"

inherit eutils

DESCRIPTION="CadSoft EAGLE schematic and printed circuit board (PCB) layout editor"
HOMEPAGE="http://www.cadsoft.de"

KEYWORDS="amd64 x86"
IUSE="doc linguas_de linguas_zh"
LICENSE="cadsoft"
RESTRICT="strip test"
SLOT="0"

SRC_URI="ftp://ftp.cadsoft.de/eagle/program/${PV%\.[0-9]}/${PN}-lin-${PV}.run"

QA_FLAGS_IGNORED="opt/eagle-${PV}/bin/eagle"

RDEPEND="sys-libs/glibc
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x86? ( media-libs/jpeg:62
		media-libs/libpng:1.2
		=dev-libs/openssl-0.9.8* )
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"

# Append ${PV} since that's what upstream installs to
INSTALLDIR="/opt/eagle-${PV}"
case "${LINGUAS}" in
	*de*)
		MY_LANG="de";;
	*)
		MY_LANG="en";;
esac
# Mandatory documentation being installed
DOCS="README_${MY_LANG} UPDATE_${MY_LANG} library_${MY_LANG}.txt"

src_unpack() {

	# Extract the built-in .tar.bz2 file starting at __DATA__
	sed  -e '1,/^__DATA__$/d' "${DISTDIR}/${A}" | tar xj || die "unpacking failed"

}

src_install() {

	# Set MY_LANG for this function only since UPDATE_zh and README_zh
	# don't exist
	[[ ${LINGUAS} == *zh* ]] && MY_INST_LANG="zh" || MY_INST_LANG="${MY_LANG}"

	cd "${S}"
	dodir ${INSTALLDIR}
	# Copy all to INSTALLDIR
	cp -r . "${D}"/${INSTALLDIR}

	# Install wrapper (suppressing leading tabs)
	# see bug #188368 or http://www.cadsoft.de/faq.htm#17040701
	exeinto /usr/bin
	newexe "${FILESDIR}/eagle_wrapper_script" eagle-${PV}
	dosym eagle-${PV} /usr/bin/eagle
	# Finally, append the path of the eagle binary respecting INSTALLDIR and any
	# arguments passed to the script (thanks Denilson)
	echo "${INSTALLDIR}/bin/eagle" '"$@"' >> "${D}/usr/bin/eagle-${PV}"

	# Install the documentation
	cd doc
	dodoc ${DOCS}
	doman eagle.1
	# Install extra documentation if requested
	use doc && dodoc elektro-tutorial.pdf manual_${MY_INST_LANG}.pdf tutorial_${MY_INST_LANG}.pdf
	# Remove docs left in INSTALLDIR
	rm -rf "${D}${INSTALLDIR}/doc"
	cd ..

	echo -e "ROOTPATH=${INSTALLDIR}/bin\nPRELINK_PATH_MASK=${INSTALLDIR}" > "${S}/90eagle-${PV}"
	doenvd "${S}/90eagle-${PV}"

	# Create desktop entry
	mv bin/${PN}icon50.png bin/${PF}-icon50.png
	doicon bin/${PF}-icon50.png
	make_desktop_entry "${ROOT}/usr/bin/eagle-${PV}" "CadSoft EAGLE Layout Editor" ${PF}-icon50 "Graphics;Electronics"

}

pkg_postinst() {

	elog "Run \`env-update && source /etc/profile\` from within \${ROOT}"
	elog "now to set up the correct paths."
	elog "You must first run eagle as root to invoke product registration."
	echo
	ewarn "Due to some necessary changes in the data structure, once you edit"
	ewarn "a file with version 5.x you will no longer be able to edit it"
	ewarn "with versions prior to 5.0!"
	ewarn
	ewarn "Please read /usr/share/doc/${PF}/UPDATE_${MY_LANG} if you are upgrading from 4.xx."

}
