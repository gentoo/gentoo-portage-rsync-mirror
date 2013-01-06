# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/deskbar-applet/deskbar-applet-2.32.0.ebuild,v 1.13 2012/10/23 06:40:00 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"

inherit eutils gnome2 python

DESCRIPTION="An Omnipresent Versatile Search Interface"
HOMEPAGE="http://projects.gnome.org/deskbar-applet/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="eds spell"

RDEPEND="
	>=x11-libs/gtk+-2.20:2
	>=gnome-base/gnome-desktop-2.10:2
	>=gnome-base/gconf-2:2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )

	>=dev-python/pygtk-2.12:2
	>=dev-python/pygobject-2.15.3:2
	>=dev-python/dbus-python-0.80.2

	>=dev-python/gconf-python-2.22.1:2
	>=dev-python/gnome-applets-python-2.22
	>=dev-python/gnome-desktop-python-2.22
	>=dev-python/gnome-keyring-python-2.22
	>=dev-python/libwnck-python-2.22

	eds? ( >=gnome-extra/evolution-data-server-1.7.92 )
	spell? ( >=gnome-extra/gnome-utils-2.16.2 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	virtual/pkgconfig
	app-text/docbook-xml-dtd:4.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		$(use_enable eds evolution)
		--exec-prefix=/usr
		--disable-scrollkeeper"
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}/${P}-glib-2.32.patch" #439194

	gnome2_src_prepare

	python_clean_py-compile_files

	python_convert_shebangs -r 2 .
}

src_compile() {
	# Needed for import gnomedesktop in configure, bug #270524
	addpredict "$(unset HOME; echo ~)/.gnome2"

	gnome2_src_compile
}

src_install() {
	gnome2_src_install
	python_clean_installation_image
	python_convert_shebangs 2 "${ED}"usr/libexec/${PN}/${PN}
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize deskbar
	python_mod_optimize /usr/libexec/deskbar-applet/deskbar-applet
	python_mod_optimize /usr/libexec/deskbar-applet/modules-2.20-compatible

	if ! has_version gnome-extra/gnome-utils; then
		ewarn "The dictionary plugin in deskbar-applet uses the dictionary from "
		ewarn "gnome-extra/gnome-utils.  If it is not present, the dictionary "
		ewarn "plugin will fail silently."
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup deskbar
	python_mod_cleanup /usr/libexec/deskbar-applet/deskbar-applet
	python_mod_cleanup /usr/libexec/deskbar-applet/modules-2.20-compatible
}
