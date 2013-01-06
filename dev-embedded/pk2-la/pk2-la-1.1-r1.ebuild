# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pk2-la/pk2-la-1.1-r1.ebuild,v 1.1 2012/04/29 16:49:04 josejx Exp $

EAPI="2"

DESCRIPTION="Logic Analyzer and I/O Probe for the Microchip PICkit2"
HOMEPAGE="http://sourceforge.net/projects/pk2-la"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/pyusb:0
	dev-python/pygtk"

src_compile() {
	### Nothing to compile
	echo
}

src_install() {
	### Install the program
	exeinto /usr/bin
	doexe "${S}/pk2-la"
	### Install the documentation
	dodoc "${S}/README" "${S}/LA-Format" "${S}/IO-Format" "${S}/CHANGELOG"
}
