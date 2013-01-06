# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/camd/camd-2.2.3.ebuild,v 1.3 2012/10/15 21:30:14 naota Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes
inherit autotools-utils

MY_PN=CAMD

DESCRIPTION="Library to order a sparse matrix prior to Cholesky factorization"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/camd/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc static-libs"

DEPEND="sci-libs/ufconfig"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-2.2.0-autotools.patch )
DOCS=( README.txt Doc/ChangeLog )

S="${WORKDIR}/${MY_PN}"

src_install() {
	autotools-utils_src_install
	use doc && dodoc Doc/CAMD_UserGuide.pdf
}
