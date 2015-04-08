# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdbcns/pdbcns-2.0.010504.ebuild,v 1.1 2012/03/01 16:12:16 jlec Exp $

EAPI=4

DESCRIPTION="Convert atom names for common amino acids and nucleic acid bases from PDB format to CNS or back"
HOMEPAGE="http://www.mybiosoftware.com/3d-molecular-model/314/"
#SRC_URI="http://kinemage.biochem.duke.edu/php/downlode.php?filename=/downloads/software/scripts/${PN}.${PV}.perl.tgz"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${PN}.${PV}.perl.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/perl"

S="${WORKDIR}"/${PN}

src_install() {
	newbin ${PN}*.pl ${PN}
	dohtml *html
}
