# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-hangul/fcitx-hangul-0.2.1.ebuild,v 1.4 2013/08/03 14:48:35 ago Exp $

EAPI=5
inherit cmake-utils gnome2-utils

DESCRIPTION="Korean Hangul module for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.7
	app-i18n/libhangul"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/libintl"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
