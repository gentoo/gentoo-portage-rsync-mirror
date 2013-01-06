# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnome-disk-utility/gnome-disk-utility-3.6.1.ebuild,v 1.1 2012/12/24 16:26:33 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Disk Utility for GNOME using udisks"
HOMEPAGE="http://git.gnome.org/browse/gnome-disk-utility"

LICENSE="GPL-2+"
SLOT="0"
IUSE="fat"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	>=dev-libs/glib-2.31:2
	>=sys-fs/udisks-1.99.0:2
	>=x11-libs/gtk+-3.5.8:3
	>=app-crypt/libsecret-0.7
	dev-libs/libpwquality
"
RDEPEND="${COMMON_DEPEND}
	>=x11-themes/gnome-icon-theme-symbolic-2.91
	fat? ( sys-fs/dosfstools )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50
	dev-libs/libxslt
	virtual/pkgconfig
"

src_configure() {
	G2CONF="${G2CONF} --disable-libsystemd-login"
	gnome2_src_configure
}
