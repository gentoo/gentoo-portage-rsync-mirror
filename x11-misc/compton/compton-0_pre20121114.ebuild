# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/compton/compton-0_pre20121114.ebuild,v 1.1 2012/11/17 23:24:46 hasufell Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="A compositor for X, and a fork of xcompmgr-dana"
HOMEPAGE="http://github.com/chjj/compton"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-libs/libconfig
	virtual/opengl
	dev-libs/libpcre:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXrender"
RDEPEND="${COMMON_DEPEND}
	app-shells/bash
	x11-apps/xprop
	x11-apps/xwininfo"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-libs/libdrm
	x11-proto/xproto"

pkg_setup() {
	tc-export CC
}

src_install() {
	default
	dodoc compton.sample.conf
}
