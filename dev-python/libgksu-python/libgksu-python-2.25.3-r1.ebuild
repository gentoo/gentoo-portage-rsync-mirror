# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgksu-python/libgksu-python-2.25.3-r1.ebuild,v 1.1 2014/05/26 17:44:23 mgorny Exp $

EAPI="5"

# The 'gksu' and 'gksuui' bindings are not supported. We don't have =libgksu-1*
# in tree.
GNOME_ORG_MODULE="gnome-python-extras"
G_PY_BINDINGS="gksu2"
PYTHON_COMPAT=( python2_7 )

inherit autotools eutils gnome-python-common-r1

DESCRIPTION="Python bindings for libgksu"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=x11-libs/libgksu-2.0.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gnome-base/gnome-common"
# eautoreconf needs gnome-base/gnome-common

EXAMPLES=( examples/gksu2/. )

src_prepare() {
	epatch "${FILESDIR}/${P}-python-libs.patch" #344231
	eautoreconf
	gnome-python-common-r1_src_prepare
}
