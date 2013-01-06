# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/colamd/colamd-2.7.1.ebuild,v 1.16 2011/06/26 13:32:17 jlec Exp $

EAPI=2

inherit autotools eutils

MY_PN=COLAMD
DESCRIPTION="Column approximate minimum degree ordering algorithm"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/colamd/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

DEPEND="sci-libs/ufconfig"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
}
