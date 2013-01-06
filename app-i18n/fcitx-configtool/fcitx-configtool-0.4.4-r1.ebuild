# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-configtool/fcitx-configtool-0.4.4-r1.ebuild,v 1.1 2012/07/19 09:07:21 yngwin Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A GTK+ GUI to edit fcitx settings"
HOMEPAGE="http://fcitx.googlecode.com/"
SRC_URI="${HOMEPAGE}files/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk gtk3"
REQUIRED_USE="|| ( gtk gtk3 )"

RDEPEND=">=app-i18n/fcitx-4.2.4
	dev-libs/glib:2
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3	)"
DEPEND="${RDEPEND}
	app-arch/xz-utils
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
