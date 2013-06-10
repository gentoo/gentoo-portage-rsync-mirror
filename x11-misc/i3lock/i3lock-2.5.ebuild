# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/i3lock/i3lock-2.5.ebuild,v 1.1 2013/06/10 19:23:49 jer Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Simple screen locker"
HOMEPAGE="http://i3wm.org/i3lock/"
SRC_URI="http://i3wm.org/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/libev
	virtual/pam
	x11-libs/cairo[xcb]
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/xcb-util-image
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
DOCS=( README )

src_prepare() {
	sed -i -e 's:login:system-auth:' ${PN}.pam || die
	tc-export CC
}

src_install() {
	default
	doman ${PN}.1
}
