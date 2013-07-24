# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-chewing/fcitx-chewing-0.2.1.ebuild,v 1.1 2013/07/24 11:17:55 yngwin Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Chewing module for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.8
	dev-libs/libchewing"
DEPEND="${RDEPEND}
	virtual/libintl"
