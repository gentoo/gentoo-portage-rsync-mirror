# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnome-music/gnome-music-3.10.3.ebuild,v 1.1 2014/02/27 20:51:45 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{3_2,3_3} )

inherit gnome2 python-single-r1

DESCRIPTION="Music management for Gnome"
HOMEPAGE="http://wiki.gnome.org/Apps/Music"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
# Let people emerge this by default, bug #472932
IUSE+=" python_single_target_python3_2 +python_single_target_python3_3"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

KEYWORDS="~amd64"

COMMON_DEPEND="
	${PYTHON_DEPS}
	>=dev-libs/glib-2.28:2
	>=dev-libs/gobject-introspection-1.35.9
	>=media-libs/grilo-0.2.6:0.2[introspection]
	>=x11-libs/gtk+-3.9:3[introspection]
"
RDEPEND="${COMMON_DEPEND}
	app-misc/tracker[introspection(+)]
	|| (
		app-misc/tracker[gstreamer]
		app-misc/tracker[xine]
	)
	dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	media-libs/gstreamer:1.0[introspection]
	media-libs/gst-plugins-base:1.0[introspection]
	media-plugins/gst-plugins-meta:1.0
	media-plugins/grilo-plugins:0.2
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.26
	virtual/pkgconfig
"
