# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/xephem/xephem-3.7.3.ebuild,v 1.14 2012/10/24 19:25:50 ulm Exp $

EAPI=1

inherit eutils multilib

DESCRIPTION="Interactive tool for astronomical ephemeris and sky simulation"
SRC_URI="http://www.clearskyinstitute.com/xephem/${P}.tar.gz"
HOMEPAGE="http://www.clearskyinstitute.com/xephem"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""
SLOT="0"
LICENSE="XEphem"
DEPEND=">=x11-libs/motif-2.3:0
	virtual/jpeg
	media-libs/libpng"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# make sure we use system libs not the ones that
	# ship with the xephem tarball
	rm -fr libjpegd/ libpng/ libz/ libXm/ GUI/xephem/tools/indi \
		|| die "Failed to remove unneeded libs and tools"
	epatch "${FILESDIR}"/${P}-use-system-lib.patch

	for i in libastro/Makefile libip/Makefile liblilxml/Makefile \
		GUI/xephem/Makefile GUI/xephem/tools/*/Makefile ; do
		einfo "Fixing CFLAGS in ${i}"
		sed -e "s~^CFLAGS[ ]*=\(.*\)-O2\(.*\)~CFLAGS= \1 \2 ${CFLAGS}~" \
			-i ${i} \
			|| die "sed failed"
	done
	sed -e 's~^CFLAGS[ ]*=\(.*\)$(CLDFLAGS)\(.*\)~CFLAGS=\1 \2~' \
		-i GUI/xephem/Makefile \
		|| die "sed in GUI/xephem failed"
}

src_compile() {

	cd libastro
	emake || die "emake failed"
	local myldflags
	cd "${S}"
	for dir in libip liblilxml GUI/xephem/tools/* GUI/xephem; do
		echo "going into ${dir}"
		cd "${S}"/${dir}
		if [ ${dir:0:3} != "lib" ]; then
			myldflags="${CLDFLAGS}"
		fi
		emake \
			MOTIFI="/usr/include" \
			MOTIFL="/usr/$(get_libdir)" \
			CLDFLAGS="${myldflags}" \
			|| die "emake in ${dir} failed"
	done
}

src_install() {

	into /usr
	cd "${S}"/GUI/xephem
	dobin xephem  || die "dobin xephem failed"
	for file in tools/{lx200xed/lx200xed,xedb/xedb,xephemdbd/xephemdbd}; do
		dobin ${file} || die "dobin ${file} failed"
	done
	doman xephem.1
	mv tools .. # do not install tool sources into share directory
	for i in $(find . -mindepth 1 -type d); do
		insinto /usr/share/${PN}/${i}
		doins ${i}/*
	done

	echo > "${S}/XEphem" "XEphem.ShareDir: /usr/share/${PN}"
	insinto /usr/share/X11/app-defaults
	has_version '<x11-base/xorg-x11-7.0' && \
		insinto /etc/X11/app-defaults
	doins "${S}"/XEphem

	cd "${S}"
	dodoc Copyright README INSTALL
	newicon GUI/xephem/XEphem.png ${PN}.png
	make_desktop_entry xephem XEphem ${PN}
}
