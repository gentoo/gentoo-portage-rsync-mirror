# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-core-libs/gnome-core-libs-3.6.2.ebuild,v 1.3 2013/01/01 14:20:37 ago Exp $

EAPI="5"

DESCRIPTION="Sub-meta package for the core libraries of GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="cups python"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"

# Note to developers:
# This is a wrapper for the core libraries used by GNOME 3
RDEPEND="
	>=dev-libs/glib-2.34.2:2
	>=x11-libs/gdk-pixbuf-2.26.5:2
	>=x11-libs/pango-1.32.2
	>=media-libs/clutter-1.12.2:1.0
	>=x11-libs/gtk+-${PV}:3[cups?]
	>=dev-libs/atk-2.6
	>=x11-libs/libwnck-3.4.4:3
	>=gnome-base/librsvg-2.36.4[gtk]
	>=gnome-base/gnome-desktop-${PV}:3
	>=gnome-base/libgnomekbd-3.6
	>=x11-libs/startup-notification-0.12

	>=gnome-base/gvfs-1.14.2
	>=gnome-base/dconf-0.14.1

	|| (
		>=media-libs/gstreamer-0.10.36:0.10
		>=media-libs/gstreamer-1.0.2:1.0 )
	|| (
		>=media-libs/gst-plugins-base-0.10.36:0.10
		>=media-libs/gst-plugins-base-1.0.2:1.0 )
	|| (
		>=media-libs/gst-plugins-good-0.10.31:0.10
		>=media-libs/gst-plugins-good-1.0.2:1.0 )

	python? ( >=dev-python/pygobject-3.2.1:3 )
"
DEPEND=""

S="${WORKDIR}"

pkg_pretend() {
	elog "See http://www.gentoo.org/proj/en/desktop/gnome/howtos/gnome-3.6-upgrade.xml"
	elog "for the Gentoo GNOME 3.6 upgrade guide."
}
