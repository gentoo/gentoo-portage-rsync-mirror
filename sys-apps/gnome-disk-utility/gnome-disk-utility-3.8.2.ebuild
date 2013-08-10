# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnome-disk-utility/gnome-disk-utility-3.8.2.ebuild,v 1.5 2013/08/10 10:28:50 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="Disk Utility for GNOME using udisks"
HOMEPAGE="http://git.gnome.org/browse/gnome-disk-utility"

LICENSE="GPL-2+"
SLOT="0"
IUSE="fat +gnome systemd"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	>=dev-libs/glib-2.31:2
	>=sys-fs/udisks-2.1.0:2
	>=x11-libs/gtk+-3.5.8:3
	>=app-crypt/libsecret-0.7
	dev-libs/libpwquality
	systemd? ( >=sys-apps/systemd-44 )
"
RDEPEND="${COMMON_DEPEND}
	>=media-libs/libdvdread-4.2.0
	>=media-libs/libcanberra-0.1[gtk3]
	>=x11-libs/libnotify-0.7:=
	>=x11-themes/gnome-icon-theme-symbolic-2.91
	fat? ( sys-fs/dosfstools )
	gnome? ( >=gnome-base/gnome-settings-daemon-3.8 )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50
	dev-libs/libxslt
	virtual/pkgconfig
"

src_prepare() {
	# Fix USE=-gnome, bug #478820
	epatch "${FILESDIR}"/${PN}-3.8.2-kill-gsd-automagic.patch
	epatch "${FILESDIR}"/${PN}-3.8.2-raise-gsd-dependency.patch

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_enable gnome gsd-plugin) \
		$(use_enable systemd libsystemd-login)
}
