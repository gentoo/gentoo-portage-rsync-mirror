# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bmon/bmon-3.2.ebuild,v 1.1 2014/02/28 18:02:19 jer Exp $

EAPI=5
inherit autotools eutils toolchain-funcs

DESCRIPTION="interface bandwidth monitor"
HOMEPAGE="http://www.infradead.org/~tgr/bmon/"
SRC_URI="
	https://codeload.github.com/tgraf/${PN}/tar.gz/v${PV} -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

RDEPEND="
	>=sys-libs/ncurses-5.3-r2
	dev-libs/confuse
	dev-libs/libnl:3
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

DOCS=( ChangeLog )

src_prepare() {
	epatch_user
	eautoreconf
}

src_configure() {
	econf \
		CURSES_LIB="$( $(tc-getPKG_CONFIG) --libs ncurses)"
}
