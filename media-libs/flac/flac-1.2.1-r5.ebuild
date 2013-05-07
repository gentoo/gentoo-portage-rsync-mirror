# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.2.1-r5.ebuild,v 1.3 2013/05/07 11:58:12 mgorny Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
inherit autotools-multilib

DESCRIPTION="free lossless audio encoder and decoder"
HOMEPAGE="http://flac.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-embedded-m4.tar.bz2"

LICENSE="BSD FDL-1.2 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="3dnow altivec +cxx debug ogg sse static-libs"

RDEPEND="ogg? ( >=media-libs/libogg-1.1.3[${MULTILIB_USEDEP}] )
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224 )"
DEPEND="${RDEPEND}
	abi_x86_32? ( dev-lang/nasm )
	!elibc_uclibc? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	local PATCHES=(
		"${FILESDIR}"/${P}-asneeded.patch
		"${FILESDIR}"/${P}-cflags.patch
		"${FILESDIR}"/${P}-asm.patch
		"${FILESDIR}"/${P}-dontbuild-tests.patch
		"${FILESDIR}"/${P}-dontbuild-examples.patch
		"${FILESDIR}"/${P}-gcc-4.3-includes.patch
		"${FILESDIR}"/${P}-ogg-m4.patch
	)

	cp "${WORKDIR}"/*.m4 m4 || die

	# bug 466990
	sed -i "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" configure.in || die

	# fix html install with out-of-source build
	sed -i -e 's:cd api:cd $(srcdir)/api:' doc/html/Makefile.am || die

	AT_M4DIR="m4" \
	autotools-multilib_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
		$(use_enable sse)
		$(use_enable 3dnow)
		$(use_enable altivec)
		--disable-doxygen-docs
		--disable-xmms-plugin
		$(use_enable cxx cpplibs)
		$(use_enable ogg)
		--disable-examples
	)
	autotools-multilib_src_configure
}

src_test() {
	if [[ ${UID} != 0 ]]; then
		autotools-multilib_src_test
	else
		ewarn "Tests will fail if ran as root, skipping."
	fi
}

src_install() {
	autotools-multilib_src_install \
		docdir=/usr/share/doc/${PF}/html
}
