# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-configtool/fcitx-configtool-0.4.1.ebuild,v 1.5 2012/07/01 07:58:19 qiaomuf Exp $

EAPI="3"

inherit cmake-utils

DESCRIPTION="A gtk GUI to edit fcitx settings"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk gtk3"

RDEPEND="dev-libs/glib:2
	gtk? (
		x11-libs/gtk+:2
	)
	gtk3? (
		x11-libs/gtk+:3
	)"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	~app-i18n/fcitx-4.2.1
	app-text/iso-codes
	dev-libs/libunique:1
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable gtk GTK2)
		$(cmake-utils_use_enable gtk3 GTK3)"
	cmake-utils_src_configure
}
