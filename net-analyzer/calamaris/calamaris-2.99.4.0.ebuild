# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/calamaris/calamaris-2.99.4.0.ebuild,v 1.2 2012/09/03 21:53:02 blueness Exp $

DESCRIPTION="Calamaris parses the logfiles of a wide variety of Web proxy servers and generates reports"
HOMEPAGE="http://calamaris.cord.de/"
SRC_URI="http://calamaris.cord.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/GDGraph"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:\(use lib\).*$:\1 '/usr/share/';:" \
		calamaris
}

src_install() {
	dobin calamaris calamaris-cache-convert

	insinto /usr/share/${PN}
	doins *.pm

	doman calamaris.1

	dodoc BUGS CHANGES EXAMPLES EXAMPLES.v3 README TODO \
		calamaris.conf
}
