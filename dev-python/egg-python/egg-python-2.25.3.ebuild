# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/egg-python/egg-python-2.25.3.ebuild,v 1.10 2013/02/02 22:28:32 ago Exp $

EAPI="2"

# We don't support the egg.recent bindings that are also provided - they are
# deprecated, have deps we don't really want and there are no users in-tree.
G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="eggtray"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit autotools eutils gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="EggTrayIcon bindings for Python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=dev-python/libbonobo-python-2.22.1
	>=dev-python/libgnome-python-2.22.1"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gnome-base/gnome-common"
# eautoreconf needs gnome-base/gnome-common

EXAMPLES="examples/egg/tray*"

src_prepare() {
	epatch "${FILESDIR}/${P}-python-libs.patch" #344231
	eautoreconf
	gnome-python-common_src_prepare
}
