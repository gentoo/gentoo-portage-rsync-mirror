# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgda-python/libgda-python-2.25.3-r1.ebuild,v 1.1 2014/05/26 17:32:07 mgorny Exp $

EAPI="5"

GNOME_ORG_MODULE="gnome-python-extras"
G_PY_BINDINGS="gda"
PYTHON_COMPAT=( python2_7 )

inherit autotools eutils gnome-python-common-r1

DESCRIPTION="Python bindings for interacting with libgda"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-extra/libgda-4:4
	>=dev-python/libbonobo-python-2.22.1:2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gnome-base/gnome-common"
# eautoreconf needs gnome-base/gnome-common

src_prepare() {
	epatch "${FILESDIR}/${P}-python-libs.patch" #344231
	eautoreconf
	gnome-python-common-r1_src_prepare
}
