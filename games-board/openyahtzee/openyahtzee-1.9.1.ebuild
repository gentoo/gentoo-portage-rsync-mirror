# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/openyahtzee/openyahtzee-1.9.1.ebuild,v 1.6 2013/01/16 14:56:16 ago Exp $

EAPI=2
WX_GTK_VER="2.8"
inherit wxwidgets toolchain-funcs versionator games

DESCRIPTION="A full-featured wxWidgets version of the classic dice game Yahtzee"
HOMEPAGE="http://openyahtzee.sourceforge.net/"
SRC_URI="mirror://sourceforge/openyahtzee/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE=""

RDEPEND="x11-libs/wxGTK:2.8[X]"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.6
	dev-libs/boost"

pkg_setup() {
	local ver=4.6
	local msg="You need at least GCC ${ver}.x for C++11 range-based 'for' and nullptr support."
	if ! version_is_at_least ${ver} $(gcc-version); then
		eerror ${msg}
		die ${msg}
	fi

	games_pkg_setup
}

src_configure() {
	egamesconf --datadir=/usr/share || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog TODO
	prepgamesdirs
}
