# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hamster-applet/hamster-applet-2.32.1-r1.ebuild,v 1.5 2013/03/27 10:26:36 ago Exp $

EAPI=5
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"
PYTHON_COMPAT=( python2_{6,7} )
PYTHON_REQ_USE="sqlite"

inherit eutils gnome2 multilib python-single-r1 waf-utils

DESCRIPTION="Time tracking for the masses, in a GNOME applet"
HOMEPAGE="http://projecthamster.wordpress.com/"

# license on homepage is out-of-date, was changed to GPL-2 on 2008-04-16
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 ~sparc x86"
IUSE="eds libnotify"

RDEPEND="dev-python/gconf-python
	dev-python/libgnome-python
	dev-python/libwnck-python
	dev-python/gnome-applets-python
	dev-python/gnome-desktop-python
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	>=dev-python/pygobject-2.14:2[${PYTHON_USEDEP}]
	>=dev-python/pygtk-2.12:2[${PYTHON_USEDEP}]
	gnome-base/gnome-control-center
	>=x11-libs/gtk+-2.12:2
	x11-libs/libXScrnSaver

	eds? ( dev-python/evolution-python )
	libnotify? ( dev-python/notify-python )
"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	sys-devel/gettext
	>=app-text/gnome-doc-utils-0.17.3"

src_prepare() {
	# Fix existing activities edition, bug #455536
	epatch "${FILESDIR}/${P}-fix-edit.patch"
	gnome2_src_prepare
}

src_configure() {
	waf-utils_src_configure
}

src_compile() {
	waf-utils_src_compile
}

src_install() {
	waf-utils_src_install
	python_fix_shebang "${ED}"usr/bin/*
	python_fix_shebang "${ED}"usr/$(get_libdir)/${PN}/${PN}
}
