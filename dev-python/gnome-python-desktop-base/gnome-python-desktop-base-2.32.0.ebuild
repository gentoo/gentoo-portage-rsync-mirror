# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python-desktop-base/gnome-python-desktop-base-2.32.0.ebuild,v 1.9 2012/05/04 15:12:17 patrick Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2"
GNOME_ORG_MODULE="gnome-python-desktop"

inherit gnome2 python

# This ebuild does nothing -- we just want to get the pkgconfig file installed

DESCRIPTION="Provides python the base files for the Gnome Python Desktop bindings"
HOMEPAGE="http://pygtk.org/"

KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"

# From the gnome-python-desktop eclass
RDEPEND=">=dev-python/pygtk-2.10.3:2
	>=dev-libs/glib-2.6.0:2
	>=x11-libs/gtk+-2.4.0:2
	!<dev-python/gnome-python-extras-2.13
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

RESTRICT="test"

pkg_setup() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
	G2CONF="${G2CONF} --disable-allbindings"
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare
	python_convert_shebangs -r 2 .
}
