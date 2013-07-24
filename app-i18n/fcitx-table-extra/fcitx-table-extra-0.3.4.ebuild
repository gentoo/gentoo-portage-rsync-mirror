# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-table-extra/fcitx-table-extra-0.3.4.ebuild,v 1.1 2013/07/24 14:26:02 yngwin Exp $

EAPI=5
inherit cmake-utils gnome2-utils

DESCRIPTION="Extra tables for Fcitx, including Boshiamy, Zhengma, Cangjie and Quick"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.8[table]"
DEPEND="${RDEPEND}
	virtual/libintl"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
