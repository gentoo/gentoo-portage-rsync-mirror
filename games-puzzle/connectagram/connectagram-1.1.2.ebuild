# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/connectagram/connectagram-1.1.2.ebuild,v 1.1 2014/08/26 05:37:35 mr_bones_ Exp $

EAPI=5
inherit eutils gnome2-utils qt4-r2 games

DESCRIPTION="A word unscrambling game"
HOMEPAGE="http://gottcode.org/connectagram/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-qt/qtcore-4.6:4
	>=dev-qt/qtgui-4.6:4"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch

	sed -i \
		-e "s#@GAMES_BINDIR@#${GAMES_BINDIR}#" \
		-e "s#@GAMES_DATADIR@#${GAMES_DATADIR}#" \
		${PN}.pro src/{locale_dialog,new_game_dialog,wordlist}.cpp || die
}

src_configure() {
	qt4-r2_src_configure
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dodoc ChangeLog
	prepgamesdirs
}

pkg_preinst() {
	gnome2_icon_savelist
	games_pkg_preinst
}

pkg_postinst() {
	gnome2_icon_cache_update
	games_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
}
