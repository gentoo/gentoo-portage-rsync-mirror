# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/free42/free42-1.4.74.ebuild,v 1.6 2012/07/05 16:06:12 nimiux Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="An HP-42S Calculator Simulator"
HOMEPAGE="http://thomasokken.com/free42/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/atk
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i -e '/^CXXFLAGS :=/{s/-g //;s/$/ \$\{CXXFLAGS\}/}' \
		"${S}/gtk/Makefile" || die
	sed -i -e '/^LDFLAGS =/{s/=/:=/;s/$/ \$\{LDFLAGS\}/}' \
		"${S}/gtk/Makefile" || die
	sed -i -e '/^LDFLAGS +=/d' "${S}/gtk/Makefile" || die
}

src_compile() {
	emake -j1 CXX="$(tc-getCXX)" -C "${S}/gtk"
}

src_install() {
	dodoc CREDITS HISTORY README TODO
	dobin gtk/free42bin
}
