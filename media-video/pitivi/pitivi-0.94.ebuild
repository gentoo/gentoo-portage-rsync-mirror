# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pitivi/pitivi-0.94.ebuild,v 1.1 2015/02/03 20:34:29 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python3_4 )

inherit gnome2 python-single-r1 eutils virtualx multilib

DESCRIPTION="A non-linear video editor using the GStreamer multimedia framework"
HOMEPAGE="http://www.pitivi.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="v4l test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	>=dev-python/pycairo-1.10[${PYTHON_USEDEP}]
	>=x11-libs/cairo-1.10
"
RDEPEND="${COMMON_DEPEND}
	dev-libs/glib:2

	>=dev-libs/gobject-introspection-1.34
	dev-python/dbus-python[${PYTHON_USEDEP}]
	>=dev-python/gst-python-1.1.90:1.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/pygobject-3.8:3[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]

	gnome-base/librsvg:=

	>=media-libs/clutter-1.12:1.0[introspection]
	>=media-libs/clutter-gst-2:2.0[introspection]
	>=media-libs/clutter-gtk-1.4:1.0[introspection]
	>=media-libs/gnonlin-1.4:1.0
	>=media-libs/gstreamer-1.4:1.0[introspection]
	>=media-libs/gstreamer-editing-services-1.4:1.0[introspection]
	>=media-libs/gst-plugins-base-1.4:1.0
	>=media-libs/gst-plugins-good-1.4:1.0
	>=media-plugins/gst-plugins-libav-1.2:1.0

	x11-libs/libnotify[introspection]
	>=x11-libs/gtk+-3.8:3[introspection]

	v4l? ( >=media-plugins/gst-plugins-v4l2-1.4:1.0 )
"
DEPEND="${RDEPEND}
	dev-python/setuptools
	>=app-text/gnome-doc-utils-0.18.0
	>=dev-util/intltool-0.35.5
	sys-devel/gettext
	virtual/pkgconfig
	test? ( dev-python/mock[${PYTHON_USEDEP}] )
"

src_configure() {
	gnome2_src_configure \
		ITSTOOL="$(type -P true)" \
		--disable-static
}

src_test() {
	# Force Xvfb to be used
	unset DISPLAY
	unset DBUS_SESSION_BUS_ADDRESS
	export PITIVI_TOP_LEVEL_DIR="${S}"
	Xemake check
}

src_install() {
	gnome2_src_install
	python_fix_shebang "${D}"
}
