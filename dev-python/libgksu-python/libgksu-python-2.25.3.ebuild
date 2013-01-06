# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgksu-python/libgksu-python-2.25.3.ebuild,v 1.9 2012/08/13 09:32:35 tetromino Exp $

EAPI="2"
# The 'gksu' and 'gksuui' bindings are not supported. We don't have =libgksu-1*
# in tree.
G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="gksu2"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit autotools eutils gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="Python bindings for libgksu"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=x11-libs/libgksu-2.0.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gnome-base/gnome-common"
# eautoreconf needs gnome-base/gnome-common

EXAMPLES="examples/gksu2/*"

src_prepare() {
	epatch "${FILESDIR}/${P}-python-libs.patch" #344231
	eautoreconf
	gnome-python-common_src_prepare
}
