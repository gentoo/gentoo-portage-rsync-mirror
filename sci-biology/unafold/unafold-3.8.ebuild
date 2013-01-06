# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/unafold/unafold-3.8.ebuild,v 1.1 2011/01/13 19:01:49 weaver Exp $

EAPI="3"
inherit flag-o-matic

DESCRIPTION="Unified Nucleic Acid Folding and hybridization package"
HOMEPAGE="http://mfold.rna.albany.edu/"
SRC_URI="http://dinamelt.bioinfo.rpi.edu/download/${P}.tar.bz2"

LICENSE="unafold"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# recommended in README
	append-flags -O3
}

src_install() {
	einstall || die
}
