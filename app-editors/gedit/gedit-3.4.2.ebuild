# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-3.4.2.ebuild,v 1.2 2012/12/16 21:27:28 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes" # plugins are dlopened
PYTHON_DEPEND="2"

inherit gnome2 multilib python eutils virtualx

DESCRIPTION="A text editor for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/Gedit"

LICENSE="GPL-2+"
SLOT="0"
IUSE="+introspection +python spell zeitgeist"
KEYWORDS="~amd64 ~mips ~sh ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"

# X libs are not needed for OSX (aqua)
COMMON_DEPEND="
	>=x11-libs/libSM-1.0
	>=dev-libs/libxml2-2.5.0:2
	>=dev-libs/glib-2.28:2
	>=x11-libs/gtk+-3.3.15:3[introspection?]
	>=x11-libs/gtksourceview-3.0.0:3.0[introspection?]
	>=dev-libs/libpeas-1.1.0[gtk]

	gnome-base/gsettings-desktop-schemas
	gnome-base/gvfs

	x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM

	net-libs/libsoup:2.4

	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )
	python? (
		>=dev-libs/gobject-introspection-0.9.3
		>=x11-libs/gtk+-3.0:3[introspection]
		>=x11-libs/gtksourceview-2.91.9:3.0[introspection]
		dev-python/pycairo
		>=dev-python/pygobject-3.0.0:3[cairo] )
	spell? (
		>=app-text/enchant-1.2
		>=app-text/iso-codes-0.35 )
	zeitgeist? ( dev-libs/libzeitgeist )"

RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme-symbolic"

DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/scrollkeeper-0.3.11
	dev-libs/libxml2:2
	>=dev-util/gtk-doc-am-1
	>=dev-util/intltool-0.40
	dev-util/itstool
	>=sys-devel/gettext-0.17
	virtual/pkgconfig"
# yelp-tools, gnome-common needed to eautoreconf

pkg_setup() {
	DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README"
	G2CONF="${G2CONF}
		--disable-deprecations
		--disable-schemas-compile
		--enable-updater
		--enable-gvfs-metadata
		$(use_enable introspection)
		$(use_enable python)
		$(use_enable spell)
		$(use_enable zeitgeist)"

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	use python && python_clean_py-compile_files
}

src_test() {
	# FIXME: this should be handled at eclass level
	"${EROOT}${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/data" || die

	unset DBUS_SESSION_BUS_ADDRESS
	GSETTINGS_SCHEMA_DIR="${S}/data" Xemake check
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use python; then
		python_mod_optimize /usr/$(get_libdir)/gedit/plugins
		# FIXME: take care of gi.overrides with USE=introspection
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	if use python; then
		python_mod_cleanup /usr/$(get_libdir)/gedit/plugins
	fi
}
