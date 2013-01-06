# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/babel/babel-1.6-r1.ebuild,v 1.8 2012/03/06 16:11:28 ranger Exp $

EAPI=4

inherit eutils

DESCRIPTION="Interconvert file formats used in molecular modeling"
HOMEPAGE="http://smog.com/chem/babel/"
SRC_URI="http://smog.com/chem/babel/files/${P}.tar.Z"

SLOT="0"
LICENSE="as-is"
IUSE=""
KEYWORDS="amd64 ppc x86"

#Doesn't really seem to depend on anything (?)
DEPEND="!sci-chemistry/openbabel"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc32.diff \
		"${FILESDIR}"/${P}-makefile.patch
	tc-export CC
}

src_install () {
	emake DESTDIR="${D}"/usr/bin install

	insinto /usr/share/${PN}
	doins *.lis

	doenvd "${FILESDIR}"/10babel
	dodoc README.1ST
}
