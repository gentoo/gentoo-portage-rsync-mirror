# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog-plugins/eog-plugins-3.4.1.ebuild,v 1.1 2012/07/16 06:51:53 tetromino Exp $

EAPI="4"

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

PYTHON_DEPEND="2"

inherit gnome2 python

DESCRIPTION="Eye of GNOME plugins"
HOMEPAGE="https://live.gnome.org/EyeOfGnome/Plugins"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+flickr map +picasa +python"

RDEPEND=">=dev-libs/glib-2.26:2
	>=dev-libs/libpeas-0.7.4[python?]
	>=media-gfx/eog-3.3.6
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3

	>=media-libs/libexif-0.6.16

	flickr? ( media-gfx/postr )
	map? (
		media-libs/libchamplain:0.12[gtk]
		>=media-libs/clutter-1.9.4:1.0
		>=media-libs/clutter-gtk-1.1.2:1.0 )
	picasa? ( >=dev-libs/libgdata-0.9.1 )
	python? (
		dev-libs/libpeas[gtk,python]
		dev-python/pygobject:3
		gnome-base/gsettings-desktop-schemas
		media-gfx/eog[introspection]
		x11-libs/gtk+:3[introspection]
		x11-libs/pango[introspection] )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
"

pkg_setup() {
	local plugins="fit-to-width,exif-display,send-by-mail"
	use flickr && plugins="${plugins},postr"
	use map && plugins="${plugins},map"
	use picasa && plugins="${plugins},postasa"
	use python && plugins="${plugins},slideshowshuffle,pythonconsole,fullscreenbg"
	G2CONF="${G2CONF}
		$(use_enable python)
		--with-plugins=${plugins}
		PYTHON=${EPREFIX}/usr/bin/python2"

	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	gnome2_src_prepare
	use python && python_clean_py-compile_files
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use python; then
		python_need_rebuild
		python_mod_optimize /usr/$(get_libdir)/eog/plugins
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	use python && python_mod_cleanup /usr/$(get_libdir)/eog/plugins
}
