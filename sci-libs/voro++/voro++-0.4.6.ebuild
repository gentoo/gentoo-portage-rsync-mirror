# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/voro++/voro++-0.4.6.ebuild,v 1.1 2014/02/24 23:36:07 ottxor Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A 3D Voronoi cell software library"
HOMEPAGE="http://math.lbl.gov/voro++/"
SRC_URI="${HOMEPAGE}/download/dir/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-cmake.patch" )
