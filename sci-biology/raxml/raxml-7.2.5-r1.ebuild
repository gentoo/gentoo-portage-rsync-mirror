# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/raxml/raxml-7.2.5-r1.ebuild,v 1.1 2011/06/21 06:38:10 jlec Exp $

EAPI=4

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A Program for Sequential, Parallel & Distributed Inference of Large Phylogenetic Trees"
HOMEPAGE="http://wwwkramer.in.tum.de/exelixis/software.html"
SRC_URI="http://wwwkramer.in.tum.de/exelixis/software/RAxML-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="sse3 +threads"

# mpi is not supported in version 7.2.2. mpi is enabled by adding -DPARALLEL to CFLAGS
DEPEND="" # mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/RAxML-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch

	use sse3 && append-cflags -D__SIM_SSE3
	use threads && \
		append-cflags -D_USE_PTHREADS && \
		append-ldflags -pthread

	tc-export CC
}

src_compile() {
	emake -f Makefile.gcc
}

src_install() {
	dobin raxmlHPC
}
