# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libXcm/libXcm-0.5.2-r1.ebuild,v 1.3 2013/06/24 17:18:39 xmw Exp $

EAPI=5

inherit autotools-multilib

DESCRIPTION="reference implementation of the net-color spec"
HOMEPAGE="http://www.oyranos.org/libxcm/"
SRC_URI="mirror://sourceforge/oyranos/${PN}/${PN}-0.4.x/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X doc static-libs"

RDEPEND="X? ( x11-libs/libXmu[${MULTILIB_USEDEP}]
		x11-libs/libXfixes[${MULTILIB_USEDEP}]
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-proto/xproto[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	local myeconfargs=(
		--disable-silent-rules
		$(use_with X x11)
		$(use_enable static-libs static)
	)
	autotools-multilib_src_configure
}

src_compile() {
	autotools-multilib_src_compile
	use doc && doxygen
}

src_install() {
	autotools-multilib_src_install
	use doc && dohtml doc/html/*
}
