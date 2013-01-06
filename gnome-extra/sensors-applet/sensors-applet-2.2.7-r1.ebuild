# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/sensors-applet/sensors-applet-2.2.7-r1.ebuild,v 1.10 2012/05/05 06:25:22 jdhore Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="GNOME panel applet to display readings from hardware sensors"
HOMEPAGE="http://sensors-applet.sourceforge.net/"
SRC_URI="mirror://sourceforge/sensors-applet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="+dbus hddtemp libnotify lm_sensors video_cards_fglrx video_cards_nvidia"

RDEPEND="
	>=dev-libs/glib-2.14:2
	>=x11-libs/gtk+-2.14:2
	gnome-base/gnome-panel[bonobo]
	>=gnome-base/libgnome-2.8
	>=gnome-base/libgnomeui-2.8
	>=x11-libs/cairo-1.0.4
	hddtemp? (
		dbus? (
			>=dev-libs/dbus-glib-0.80
			>=dev-libs/libatasmart-0.16 )
		!dbus? ( >=app-admin/hddtemp-0.3_beta13 ) )
	libnotify? ( x11-libs/libnotify )
	lm_sensors? ( sys-apps/lm_sensors )
	video_cards_fglrx? ( x11-drivers/ati-drivers )
	video_cards_nvidia? ( || (
		>=x11-drivers/nvidia-drivers-100.14.09
		media-video/nvidia-settings
	) )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=app-text/scrollkeeper-0.3.14
	>=app-text/gnome-doc-utils-0.3.2
	dev-util/intltool"
# Requires libxslt only for use by gnome-doc-utils

PDEPEND="hddtemp? ( dbus? ( sys-fs/udisks:0 ) )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--disable-static
		$(use_enable dbus udisks)
		$(use_enable libnotify)
		$(use_with lm_sensors libsensors)
		$(use_with video_cards_fglrx aticonfig)
		$(use_with video_cards_nvidia nvidia)"

	if use hddtemp; then
		G2CONF="${G2CONF} $(use_enable dbus udisks)"
	else
		G2CONF="${G2CONF} --disable-udisks"
	fi
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-libnotify-0.7.patch \
		"${FILESDIR}"/${P}-underlinking.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	find "${D}"usr -name '*.la' -exec rm -f {} +
}
