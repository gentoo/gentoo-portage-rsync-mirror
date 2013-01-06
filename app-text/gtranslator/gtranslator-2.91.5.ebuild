# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-2.91.5.ebuild,v 1.3 2012/12/17 08:20:16 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="gnome? 2"

inherit gnome2 multilib python

DESCRIPTION="An enhanced gettext po file editor for GNOME"
HOMEPAGE="http://gtranslator.sourceforge.net/"

LICENSE="GPL-3+ FDL-1.1+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnome spell"

COMMON_DEPEND="
	>=dev-libs/glib-2.32:2
	>=x11-libs/gtk+-3.4.2:3
	>=x11-libs/gtksourceview-3.0.0:3.0
	>=dev-libs/gdl-2.91.91:3=
	<dev-libs/gdl-3.5
	>=dev-libs/libxml2-2.4.12:2
	>=dev-libs/json-glib-0.12.0
	>=dev-libs/libpeas-1.2[gtk]
	gnome-extra/libgda:5=
	>=app-text/iso-codes-0.35

	gnome-base/gsettings-desktop-schemas

	gnome? (
		|| ( app-dicts/gnome-dictionary	=gnome-extra/gnome-utils-3.2* )
		x11-libs/gtk+:3[introspection] )
	spell? ( app-text/gtkspell:3= )"
RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme-symbolic
	gnome? (
		>=dev-libs/libpeas-1.2[gtk,python]
		dev-python/pygobject:3
		gnome-extra/gucharmap:2.90[introspection] )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/gnome-doc-utils
	>=app-text/scrollkeeper-0.1.4
	>=dev-util/gtk-doc-am-1
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"
# eautoreconf requires gnome-base/gnome-common

pkg_setup() {
	if use gnome; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README THANKS"
	G2CONF="${G2CONF}
		--disable-static
		$(use_with gnome dictionary)
		$(use_enable gnome introspection)
		$(use_with spell gtkspell3)"

	gnome2_src_prepare

	if use gnome; then
		python_clean_py-compile_files
	else
		# don't install charmap plugin, it requires gnome-extra/gucharmap
		sed -e 's:\scharmap\s: :g' -i plugins/Makefile.* ||
			die "sed plugins/Makefile.* failed"
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use gnome; then
		python_need_rebuild
		python_mod_optimize /usr/$(get_libdir)/gtranslator/plugins
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	use gnome && python_mod_cleanup /usr/$(get_libdir)/gtranslator/plugins
}
