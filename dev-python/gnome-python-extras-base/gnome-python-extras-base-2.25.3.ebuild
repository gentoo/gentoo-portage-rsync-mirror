# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python-extras-base/gnome-python-extras-base-2.25.3.ebuild,v 1.11 2012/08/13 09:22:14 tetromino Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit versionator autotools eutils gnome2 python

# This ebuild does nothing -- we just want to get the pkgconfig file installed
MY_PN="gnome-python-extras"
DESCRIPTION="Provides python the base files for the Gnome Python Desktop bindings"
HOMEPAGE="http://pygtk.org/"
PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP}/${MY_PN}-${PV}.tar.bz2"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
RESTRICT="test"

# From the gnome-python-extras eclass
RDEPEND=">=x11-libs/gtk+-2.4:2
	>=dev-libs/glib-2.6:2
	>=dev-python/pygtk-2.10.3:2
	!<=dev-python/gnome-python-extras-2.19.1-r2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gnome-base/gnome-common"
# eautoreconf needs gnome-base/gnome-common

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --disable-allbindings"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-python-libs.patch" #344231
	eautoreconf
	gnome2_src_prepare
}
