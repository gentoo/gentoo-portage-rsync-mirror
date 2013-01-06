# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/curses-hexedit/curses-hexedit-0.9.7.ebuild,v 1.1 2012/02/27 04:57:31 vapier Exp $

# There's already a "hexedit" package in the tree, so name this one differently

EAPI="4"

MY_P=${P/curses-}
DESCRIPTION="full screen curses hex editor (with insert/delete support)"
HOMEPAGE="http://www.rogoyski.com/adam/programs/hexedit/"
SRC_URI="http://www.rogoyski.com/adam/programs/hexedit/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf --program-prefix=curses-
}
