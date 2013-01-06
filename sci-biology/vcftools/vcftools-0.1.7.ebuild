# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vcftools/vcftools-0.1.7.ebuild,v 1.1 2012/01/02 21:51:52 weaver Exp $

EAPI=4

MY_P="${PN}_${PV}"

DESCRIPTION="Tools for working with VCF (Variant Call Format) files"
HOMEPAGE="http://vcftools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e "s/CPPFLAGS =/CPPFLAGS = $CXXFLAGS /" \
		-e "s/LIB =/LIB = $LDFLAGS /" cpp/Makefile || die
}

src_install(){
	dobin bin/*
	insinto /usr/share/${PN}/perl
	doins perl/*.pm
	exeinto /usr/share/${PN}/perl
	doexe perl/{fill,vcf}-*
	echo 'COLON_SEPARATED=PERL5LIB' > "${S}/99${PN}"
	echo "PERL5LIB=/usr/share/${PN}/perl" >> "${S}/99${PN}"
	doenvd "${S}/99${PN}"
	dodoc README.txt
}
