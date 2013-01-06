# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/abyss/abyss-1.2.7.ebuild,v 1.2 2011/04/28 15:01:05 jlec Exp $

EAPI="4"

inherit autotools

DESCRIPTION="Assembly By Short Sequences - a de novo, parallel, paired-end sequence assembler"
HOMEPAGE="http://www.bcgsc.ca/platform/bioinfo/software/abyss/"
SRC_URI="http://www.bcgsc.ca/downloads/abyss/${P}.tar.gz"

LICENSE="abyss"
SLOT="0"
IUSE="+mpi openmp"
KEYWORDS="amd64 x86"

DEPEND="
	dev-cpp/sparsehash
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

# todo: --enable-maxk=N configure option
# todo: fix automagic mpi toggling

src_prepare() {
	sed -i -e "s/-Werror//" configure.ac || die #365195
	sed -i -e "/dist_pkgdoc_DATA/d" Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable openmp)
}
