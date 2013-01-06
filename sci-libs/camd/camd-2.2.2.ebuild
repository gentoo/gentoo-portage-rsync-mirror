# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/camd/camd-2.2.2.ebuild,v 1.3 2011/07/28 20:33:19 bicatali Exp $

EAPI=4

inherit autotools eutils

MY_PN=CAMD

DESCRIPTION="Library to order a sparse matrix prior to Cholesky factorization"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/camd/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc static-libs"

DEPEND="sci-libs/ufconfig"
RDEPEND="${DEPEND}"

DOCS="README.txt Doc/ChangeLog"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2.0-autotools.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use doc && dodoc Doc/CAMD_UserGuide.pdf
}
