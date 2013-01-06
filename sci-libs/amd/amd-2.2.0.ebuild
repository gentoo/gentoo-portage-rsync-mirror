# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/amd/amd-2.2.0.ebuild,v 1.23 2012/10/16 20:51:56 jlec Exp $

inherit autotools eutils fortran-2 toolchain-funcs

MY_PN=AMD

DESCRIPTION="Library to order a sparse matrix prior to Cholesky factorization"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/amd"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc"

DEPEND="sci-libs/ufconfig"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins Doc/AMD_UserGuide.pdf || die "doc install failed"
	fi
}
