# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/abyss/abyss-1.2.3.ebuild,v 1.5 2011/04/29 17:27:31 mr_bones_ Exp $

EAPI="2"

DESCRIPTION="Assembly By Short Sequences - a de novo, parallel, paired-end sequence assembler"
HOMEPAGE="http://www.bcgsc.ca/platform/bioinfo/software/abyss/"
SRC_URI="http://www.bcgsc.ca/downloads/abyss/${P}.tar.gz"

LICENSE="abyss"
SLOT="0"
IUSE="+mpi"
KEYWORDS="amd64 x86"

DEPEND="
	dev-cpp/sparsehash
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

# todo: --enable-maxk=N configure option
# todo: fix automagic mpi toggling

src_prepare() {
	sed 's:-Werror::g' -i configure || die
}

src_install() {
	einstall || die
}
