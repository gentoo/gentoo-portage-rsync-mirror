# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/igraph/igraph-0.6.4.ebuild,v 1.1 2013/02/21 20:18:15 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils

DESCRIPTION="Creating and manipulating undirected and directed graphs"
HOMEPAGE="http://igraph.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/project/${PN}/C%20library/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gmp static-libs"

DEPEND="
	dev-libs/libxml2
	sci-libs/arpack
	virtual/blas
	virtual/lapack
	sci-libs/cxsparse
	sci-mathematics/glpk
	gmp? ( dev-libs/gmp )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-unbundle.patch )

src_prepare() {
#	rm -rf src/{cs,f2c,lapack,f2c.h} optional/glpk || die
#	rm -rf src/cs optional/glpk || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable gmp)
		$(use_enable debug)
		--disable-tls
		--with-external-arpack
		--with-external-blas
		--with-external-lapack
		--with-external-f2c
		--with-external-glpk
	)
	autotools-utils_src_configure
}
