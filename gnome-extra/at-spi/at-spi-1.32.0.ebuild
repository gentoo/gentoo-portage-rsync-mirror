# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.32.0.ebuild,v 1.9 2012/05/05 06:25:18 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"

inherit gnome2 python

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://projects.gnome.org/accessibility/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=dev-libs/atk-1.29.2
	>=x11-libs/gtk+-2.19.7:2
	>=gnome-base/libbonobo-1.107
	>=gnome-base/orbit-2
	>=dev-libs/dbus-glib-0.76
	>=gnome-base/gconf-2
	dev-libs/popt

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	doc? ( >=dev-util/gtk-doc-1 )

	x11-libs/libXt
	x11-proto/xextproto
	x11-proto/inputproto
	x11-proto/xproto"
# eautoreconf needs:
#	gnome-base/gnome-common
#	dev-util/gtk-doc-am

# needs a live properly configured environment. Not really suited to
# an ebuild restricted environment
RESTRICT="test"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-sm
		--disable-xevie"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize pyatspi
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup pyatspi
}
