# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-qt5/fcitx-qt5-0.1.2.ebuild,v 1.1 2014/11/02 09:03:54 yngwin Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Qt5 input module for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.8
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5"
DEPEND="${RDEPEND}"
