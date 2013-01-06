# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/phyml/phyml-2.4.5.ebuild,v 1.3 2010/10/22 15:44:40 xarthisius Exp $

DESCRIPTION="A simple, fast, and accurate algorithm to estimate large phylogenies by maximum likelihood."
HOMEPAGE="http://atgc.lirmm.fr/phyml/"
SRC_URI="http://www.lirmm.fr/~guindon/${PN}_v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}_v${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's/^hello !!!//' -e 's/^CFLAGS =/#CFLAGS =/' -e 's/^CC =/#CC =/' Makefile
}

src_compile() {
	make
}

src_install() {
	dobin phyml
}
