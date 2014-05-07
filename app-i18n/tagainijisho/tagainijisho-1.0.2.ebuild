# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/tagainijisho/tagainijisho-1.0.2.ebuild,v 1.2 2014/05/07 14:24:23 calchan Exp $

EAPI=5

inherit cmake-utils gnome2-utils

DESCRIPTION="Open-source Japanese dictionary and kanji lookup tool"
HOMEPAGE="http://www.tagaini.net/"
SRC_URI="https://github.com/Gnurou/tagainijisho/releases/download/${PV}/${P}.tar.gz"
LICENSE="GPL-3+ public-domain"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-db/sqlite:3"
RDEPEND="${DEPEND}"

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
