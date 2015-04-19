# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-chewing/fcitx-chewing-0.2.2.ebuild,v 1.2 2015/04/19 11:52:24 blueness Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Chewing module for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.8
	>=dev-libs/libchewing-0.4.0"
DEPEND="${RDEPEND}
	virtual/libintl"
