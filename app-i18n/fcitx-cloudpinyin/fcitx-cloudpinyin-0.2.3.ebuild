# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-cloudpinyin/fcitx-cloudpinyin-0.2.3.ebuild,v 1.1 2012/07/19 08:17:06 yngwin Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A fcitx module to look up pinyin candidate words on the internet"
HOMEPAGE="http://fcitx.googlecode.com/"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-i18n/fcitx-4.2.0
	dev-util/intltool
	sys-devel/gettext
	virtual/libiconv
	virtual/pkgconfig"
RDEPEND=""
