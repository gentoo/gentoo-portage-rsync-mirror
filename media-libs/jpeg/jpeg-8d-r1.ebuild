# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-8d-r1.ebuild,v 1.2 2013/07/31 16:10:51 aballier Exp $

EAPI=5
inherit eutils libtool toolchain-funcs multilib-minimal

MY_PN=libjpeg8
MY_PV=1

DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
HOMEPAGE="http://jpegclub.org/ http://www.ijg.org/"
SRC_URI="http://www.ijg.org/files/${PN}src.v${PV}.tar.gz
	mirror://debian/pool/main/${MY_PN:0:4}/${MY_PN}/${MY_PN}_${PV}-${MY_PV}.debian.tar.gz"

LICENSE="IJG"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"
RDEPEND="abi_x86_32? ( !<=app-emulation/emul-linux-x86-baselibs-20130224-r3
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)] )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-7-maxmem_sysconf.patch
	elibtoolize
}

multilib_src_configure() {
	# Fix building against this library on eg. Solaris and DragonFly BSD, see:
	# http://mail-index.netbsd.org/pkgsrc-bugs/2010/01/18/msg035644.html
	local ldverscript=
	[[ ${CHOST} == *-solaris* ]] && ldverscript="--disable-ld-version-script"

	ECONF_SOURCE=${S} \
	econf \
		$(use_enable static-libs static) \
		--enable-maxmem=64 \
		${ldverscript}
}

multilib_src_compile() {
	emake

	if [[ ${ABI} == ${DEFAULT_ABI} ]]; then
		# Build exifautotran and jpegexiforient
		cd ../debian/extra
		emake CC="$(tc-getCC)" CFLAGS="${LDFLAGS} ${CFLAGS}"
	fi
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	prune_libtool_files

	dodoc change.log example.c README *.txt

	# Install exifautotran and jpegexiforient
	newdoc ../debian/changelog changelog.debian
	cd ../debian/extra
	emake \
		DESTDIR="${D}" prefix="${EPREFIX}"/usr \
		INSTALL="install -m755" INSTALLDIR="install -d -m755" \
		install
}

pkg_postinst() {
	ewarn "If you are switching from media-libs/libjpeg-turbo you might need to"
	ewarn "rebuild reverse dependencies:"
	ewarn
	ewarn "# emerge gentoolkit"
	ewarn "# revdep-rebuild --library libjpeg.so.8"
}
