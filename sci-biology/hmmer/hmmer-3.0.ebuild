# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/hmmer/hmmer-3.0.ebuild,v 1.7 2014/10/19 03:59:06 patrick Exp $

EAPI=4

inherit eutils

DESCRIPTION="Sequence analysis using profile hidden Markov models"
HOMEPAGE="http://hmmer.janelia.org/"
SRC_URI="ftp://selab.janelia.org/pub/software/hmmer3/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="+sse mpi +threads gsl static-libs"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos"

DEPEND="
	mpi? ( virtual/mpi )
	gsl? ( >=sci-libs/gsl-1.12 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-fix_tests.patch \
		"${FILESDIR}"/${P}-perl-5.16-2.patch
}

src_configure() {
	econf \
		$(use_enable sse) \
		$(use_enable mpi) \
		$(use_enable threads) \
		$(use_with gsl)
}

src_install() {
	default

	use static-libs && dolib.a src/libhmmer.a easel/libeasel.a

	insinto /usr/share/${PN}
	doins -r tutorial
	dodoc Userguide.pdf
}
