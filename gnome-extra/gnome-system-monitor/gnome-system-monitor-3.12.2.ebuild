# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-3.12.2.ebuild,v 1.3 2014/07/14 18:33:50 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="The Gnome System Monitor"
HOMEPAGE="https://help.gnome.org/users/gnome-system-monitor/"

LICENSE="GPL-2"
SLOT="0"
IUSE="systemd +X"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

RDEPEND="
	>=dev-libs/glib-2.37.3:2
	>=gnome-base/libgtop-2.28.2:2=
	>=x11-libs/gtk+-3.9.5:3[X(+)]
	>=x11-themes/gnome-icon-theme-2.31
	>=dev-cpp/gtkmm-3.3.18:3.0
	>=dev-cpp/glibmm-2.34:2
	>=dev-libs/libxml2-2.0:2
	>=gnome-base/librsvg-2.35:2

	systemd? ( >=sys-apps/systemd-38:0= )
	X? ( >=x11-libs/libwnck-2.91.0:3 )
"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.20
	>=dev-util/intltool-0.41.0
	virtual/pkgconfig

	systemd? ( !=sys-apps/systemd-43* )
"

src_prepare() {
	# From 'master', bug #516716
	epatch "${FILESDIR}/${PN}-3.12.2-configure-wnck.patch"
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_enable systemd) \
		$(use_enable X wnck) \
		ITSTOOL=$(type -P true)
}
