# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gtkspell-python/gtkspell-python-2.25.3.ebuild,v 1.10 2012/08/13 09:29:54 tetromino Exp $

EAPI="2"
G_PY_PN="gnome-python-extras"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit autotools eutils gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="GtkSpell bindings for Python"
# The LICENSE with gtkspell-3 is LGPL and there is no way to express this in
# an ebuild, currently. Punt till we actually have to face the issue.
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND="app-text/gtkspell:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gnome-base/gnome-common"
# eautoreconf needs gnome-base/gnome-common

EXAMPLES="examples/gtkspell/*"

src_prepare() {
	epatch "${FILESDIR}/${P}-python-libs.patch" #344231
	eautoreconf
	gnome-python-common_src_prepare
}
