# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/4ti2/4ti2-1.3.2.ebuild,v 1.6 2011/11/14 11:26:12 flameeyes Exp $

EAPI=3

inherit autotools-utils

DESCRIPTION="Software package for algebraic, geometric and combinatorial problems"
HOMEPAGE="http://www.4ti2.de/"
SRC_URI="http://4ti2.de/version_${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

DEPEND="sci-mathematics/glpk[gmp]
	dev-libs/gmp[cxx]"
RDEPEND="${DEPEND}"
