# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/infernal/infernal-1.0.2-r1.ebuild,v 1.4 2012/06/25 07:08:17 jlec Exp $

EAPI=4

inherit eutils

DESCRIPTION="Inference of RNA alignments"
HOMEPAGE="http://infernal.janelia.org/"
SRC_URI="ftp://selab.janelia.org/pub/software/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="mpi"
KEYWORDS="amd64 x86"

DEPEND="mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-parallel-build.patch \
		"${FILESDIR}"/${P}-overflows.patch \
		"${FILESDIR}"/${P}-perl-5.16.patch \
		"${FILESDIR}"/${P}-ldflags.patch
}

src_configure() {
	econf \
		--prefix="${D}/usr" \
		$(use_enable mpi)
}

src_install() {
	default

	pushd documentation/manpages > /dev/null
	for i in *;
		do newman ${i} ${i/.man/.1}
	done
	popd > /dev/null

	insinto /usr/share/${PN}
	doins -r benchmarks tutorial intro matrices
	dodoc 00README* Userguide.pdf documentation/release-notes/*
}
