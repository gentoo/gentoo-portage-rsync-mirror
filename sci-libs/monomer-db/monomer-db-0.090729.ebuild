# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/monomer-db/monomer-db-0.090729.ebuild,v 1.9 2011/10/25 06:06:56 jlec Exp $

DESCRIPTION="Monomer library used for macromolecular structure building and refinement"
HOMEPAGE="http://www.ccp4.ac.uk/"
# SRC_URI="http://www.ysbl.york.ac.uk/~garib/refmac/data/refmac_dictionary.tar.gz"
SRC_URI="http://dev.gentooexperimental.org/~jlec/science-dist/${P}.tar.gz"

LICENSE="ccp4"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="!<sci-chemistry/ccp4-6.1.3"
DEPEND="${RDEPEND}"

RESTRICT="binchecks strip"

S="${WORKDIR}"/dic

src_install() {
	insinto /usr/share/ccp4/data/monomers/
	for i in {a..z} {1..9} *list *.cif *.txt; do
		doins -r ${i} || die
	done
	dohtml *.html || die
}
