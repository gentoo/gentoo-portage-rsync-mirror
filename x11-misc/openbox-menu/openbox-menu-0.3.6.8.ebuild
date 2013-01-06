# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/openbox-menu/openbox-menu-0.3.6.8.ebuild,v 1.1 2012/12/03 17:59:02 hasufell Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Another dynamic menu generator for Openbox"
HOMEPAGE="http://mimasgpc.free.fr/openbox-menu_en.html"
SRC_URI="http://mimarchlinux.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+icons"

RDEPEND="dev-libs/glib:2
	lxde-base/menu-cache
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e 's/#define VERSION.*/#define VERSION "'${PV}'"/' \
		openbox-menu.h || die "fixing version failed!"

	epatch "${FILESDIR}"/${P}-build.patch

	tc-export CC
}

src_compile() {
	emake $(usex icons "ICONS=1" "ICONS=0")
}
