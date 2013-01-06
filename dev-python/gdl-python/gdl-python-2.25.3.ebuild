# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdl-python/gdl-python-2.25.3.ebuild,v 1.10 2012/08/13 09:25:56 tetromino Exp $

EAPI="2"
G_PY_PN="gnome-python-extras"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit autotools eutils gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="Python bindings for GDL"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=dev-libs/gdl-2.28:1"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gnome-base/gnome-common"
# eautoreconf needs gnome-base/gnome-common

EXAMPLES="examples/gdl/*"

src_prepare() {
	# Fix build failure with gdl-2.28
	epatch "${FILESDIR}/${PN}-2.19.1-gdlapi-removal.patch"
	epatch "${FILESDIR}/${P}-python-libs.patch" #344231
	eautoreconf

	gnome-python-common_src_prepare
}
