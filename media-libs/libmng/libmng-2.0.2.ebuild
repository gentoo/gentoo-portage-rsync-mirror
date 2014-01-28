# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmng/libmng-2.0.2.ebuild,v 1.3 2014/01/28 04:33:05 floppym Exp $

EAPI=5
inherit autotools-multilib

DESCRIPTION="Multiple Image Networkgraphics lib (animated png's)"
HOMEPAGE="http://www.libmng.com/"
SRC_URI="mirror://sourceforge/libmng/${P}.tar.xz"

LICENSE="libmng"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="lcms static-libs"

RDEPEND="virtual/jpeg:0[${MULTILIB_USEDEP}]
	>=sys-libs/zlib-1.1.4[${MULTILIB_USEDEP}]
	lcms? ( media-libs/lcms:2[${MULTILIB_USEDEP}] )
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-baselibs-20131008-r9
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}"

src_prepare() {
	emake distclean
	autotools-multilib_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
		--with-jpeg
		$(use_with lcms lcms2)
		--without-lcms
		)

	autotools-multilib_src_configure
}

src_install() {
	autotools-multilib_src_install

	dodoc CHANGES README* doc/{doc.readme,libmng.txt}
	doman doc/man/*.{3,5}
}
