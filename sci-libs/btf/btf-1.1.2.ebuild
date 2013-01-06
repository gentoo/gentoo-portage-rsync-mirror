# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/btf/btf-1.1.2.ebuild,v 1.2 2011/06/26 09:20:15 jlec Exp $

EAPI=4

inherit autotools eutils

MY_PN=BTF
DESCRIPTION="Algorithm for matrix permutation into block triangular form"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/btf/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="sci-libs/ufconfig"
RDEPEND=""

DOCS="README.txt Doc/ChangeLog"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.1-autotools.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
