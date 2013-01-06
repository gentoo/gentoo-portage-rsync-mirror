# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-packagekit/gnome-packagekit-3.4.2.ebuild,v 1.2 2012/12/11 09:29:35 ssuominen Exp $

EAPI="4"
GCONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit eutils gnome2 python virtualx

DESCRIPTION="PackageKit client for the GNOME desktop"
HOMEPAGE="http://www.packagekit.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nls systemd test udev"

# gdk-pixbuf ised in gpk-animated-icon
# pango used on gpk-common
RDEPEND="
	>=dev-libs/glib-2.25.9:2
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.91.0:3
	>=x11-libs/libnotify-0.7.0
	x11-libs/pango
	>=dev-libs/dbus-glib-0.73

	>=app-admin/packagekit-base-0.7.2[udev]
	>=app-admin/packagekit-gtk-0.7.2
	>=media-libs/libcanberra-0.10[gtk3]
	>=sys-apps/dbus-1.1.2
	>=sys-power/upower-0.9.0

	media-libs/fontconfig
	x11-libs/libX11

	systemd? ( >=sys-apps/systemd-42 )
	!systemd? ( sys-auth/consolekit )
	udev? ( >=virtual/udev-171[gudev] )"
DEPEND="${RDEPEND}
	app-text/docbook-sgml-utils
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.35
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )"

# NOTES:
# app-text/docbook-sgml-utils required for man pages
# app-text/gnome-doc-utils and dev-libs/libxslt required for gnome help files
# gtk-doc is generating a useless file, don't need it

# UPSTREAM:
# misuse of CPPFLAGS/CXXFLAGS ?
# see if tests can forget about display (use eclass for that ?)
# intltool and gettext only with +nls

pkg_setup() {
	DOCS="AUTHORS MAINTAINERS NEWS README TODO"
	# localstatedir: /var for upstream /var/lib for gentoo
	# scrollkeeper and schemas-install: managed by gnome2 eclass
	# tests: not working (need DISPLAY)
	# gtk-doc: not needed (builded file is useless)
#		--enable-libtool-lock
#		--disable-dependency-tracking
#		--enable-option-checking
	G2CONF="${G2CONF}
		--localstatedir=/var
		--enable-compile-warnings=yes
		--enable-iso-c
		--disable-scrollkeeper
		--disable-schemas-compile
		--disable-strict
		$(use_enable nls)
		$(use_enable systemd)
		$(use_enable test tests)
		$(use_enable udev gudev)"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Regenerate marshalers for <glib-2.31 compat
	rm -v src/gpk-marshal.{c,h} || die

	gnome2_src_prepare

	python_clean_py-compile_files

	# disable tests with graphical dialogs and that require packagekitd to be
	# run with the dummy backend
	epatch "${FILESDIR}/${PN}-3.1.90-tests.patch"

	# Fails every time packagekit developers make a tiny change to headers
	sed -e '/gpk_enum_test (test)/ d' -i src/gpk-self-test.c || die
}

src_test() {
	unset DISPLAY
	Xemake check
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize packagekit
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup packagekit
}
