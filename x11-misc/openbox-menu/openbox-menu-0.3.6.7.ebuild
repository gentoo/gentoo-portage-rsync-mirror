# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/openbox-menu/openbox-menu-0.3.6.7.ebuild,v 1.3 2012/08/27 13:30:37 johu Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Another dynamic menu generator for Openbox"
HOMEPAGE="http://mimasgpc.free.fr/openbox-menu_en.html"
SRC_URI="http://mimarchlinux.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	lxde-base/menu-cache
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}
