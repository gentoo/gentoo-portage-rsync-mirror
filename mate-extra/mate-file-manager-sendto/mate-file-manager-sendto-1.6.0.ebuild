# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-extra/mate-file-manager-sendto/mate-file-manager-sendto-1.6.0.ebuild,v 1.2 2014/05/04 14:54:39 ago Exp $

EAPI="5"

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Caja extension for sending files to locations"
HOMEPAGE="http://www.mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE="cdr gajim +mail pidgin upnp"

RDEPEND=">=dev-libs/dbus-glib-0.60:0
	>=dev-libs/glib-2.25.9:2
	>=mate-base/mate-file-manager-1.6:0
	>=sys-apps/dbus-1:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.18:2
	virtual/libintl:0
	cdr? ( >=app-cdr/brasero-2.32.1:0= )
	gajim? (
		net-im/gajim:0
		>=dev-libs/dbus-glib-0.60:0 )
	pidgin? ( >=dev-libs/dbus-glib-0.60:0 )
	upnp? ( >=net-libs/gupnp-0.13:0= )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35:*
	>=mate-base/mate-common-1.6:0
	sys-devel/gettext:*
	virtual/pkgconfig:*"

src_prepare() {
	# Tarball has no proper build system, should be fixed on next release.
	eautoreconf

	gnome2_src_prepare
}

src_configure() {
	local myconf
	myconf="--with-plugins=removable-devices,"
	use cdr && myconf="${myconf}caja-burn,"
	use mail && myconf="${myconf}emailclient,"
	use pidgin && myconf="${myconf}pidgin,"
	use gajim && myconf="${myconf}gajim,"
	use upnp && myconf="${myconf}upnp,"

	gnome2_src_configure ${myconf} \
		$(use_with gajim)
}

DOCS="AUTHORS ChangeLog NEWS README"
