# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/i3lock/i3lock-2.4.1.ebuild,v 1.3 2012/08/20 20:01:01 johu Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Simple screen locker"
HOMEPAGE="http://i3wm.org/i3lock/"
SRC_URI="http://i3wm.org/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+cairo"

RDEPEND="virtual/pam
	dev-libs/libev
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-image
	x11-libs/libX11
	cairo? ( x11-libs/cairo[xcb] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
DOCS=( README )

pkg_setup() {
	tc-export CC
}

src_prepare() {
	sed -i -e 's:login:system-auth:' ${PN}.pam || die
}

src_configure() {
	use cairo || export NOLIBCAIRO=1
}

src_install() {
	default
	doman ${PN}.1
}
