# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog-plugins/eog-plugins-3.12.1-r1.ebuild,v 1.1 2014/11/25 15:17:25 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit gnome2 python-single-r1

DESCRIPTION="Eye of GNOME plugins"
HOMEPAGE="https://wiki.gnome.org/Apps/EyeOfGnome/Plugins"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+exif +flickr map +picasa +python"
# Let people emerge this by default, bug #472932
IUSE+=" +python_single_target_python3_3"

REQUIRED_USE="
	map? ( exif )
	python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=dev-libs/libpeas-0.7.4:=
	>=media-gfx/eog-3.11.4
	>=x11-libs/gtk+-3.3.8:3
	exif? ( >=media-libs/libexif-0.6.16 )
	flickr? ( media-gfx/postr )
	map? (
		media-libs/libchamplain:0.12[gtk]
		>=media-libs/clutter-1.9.4:1.0
		>=media-libs/clutter-gtk-1.1.2:1.0 )
	picasa? ( >=dev-libs/libgdata-0.9.1:= )
	python? (
		${PYTHON_DEPS}
		dev-libs/libpeas:=[gtk,python,${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
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
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local plugins="fit-to-width,send-by-mail,hide-titlebar,light-theme"
	use exif && plugins="${plugins},exif-display"
	use flickr && plugins="${plugins},postr"
	use map && plugins="${plugins},map"
	use picasa && plugins="${plugins},postasa"
	use python && plugins="${plugins},slideshowshuffle,pythonconsole,fullscreenbg,export-to-folder"
	gnome2_src_configure \
		$(use_enable python) \
		--with-plugins=${plugins}
}
