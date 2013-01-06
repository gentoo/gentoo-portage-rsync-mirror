# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hardinfo/hardinfo-0.5.1.ebuild,v 1.1 2012/05/26 21:46:09 hasufell Exp $

EAPI=4

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A system information and benchmark tool for Linux systems"
HOMEPAGE="http://hardinfo.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	net-libs/libsoup
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_configure() {
	filter-flags "-O*"
	default
}
