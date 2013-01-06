# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/augustus/augustus-2.5.ebuild,v 1.5 2011/06/23 14:58:14 jlec Exp $

EAPI=2

inherit base eutils

DESCRIPTION="Eukaryotic gene predictor"
HOMEPAGE="http://augustus.gobics.de/"
SRC_URI="http://augustus.gobics.de/binaries/${PN}.${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}.${PV}"

src_prepare() {
	sed -i 's/${CFLAGS}/${CFLAGS} ${LDFLAGS}/' src/Makefile || die
	sed -i -e 's/CFLAGS :=/CFLAGS +=/' -e 's/gcc $(CFLAGS)/gcc $(CFLAGS) $(LDFLAGS)/' scripts/*/Makefile || die
}

src_compile() {
	emake -C src clean || die
	emake -C src || die
}

src_install() {
	dobin src/{augustus,etraining,consensusFinder,curve2hints} || die
	insinto /usr/share/${PN}
	doins -r config examples scripts docs || die
	echo "AUGUSTUS_CONFIG_PATH=\"/usr/share/${PN}/config\"" > "${S}/99${PN}"
	doenvd "${S}/99${PN}" || die
	dodoc README.TXT HISTORY.TXT docs/*
}
