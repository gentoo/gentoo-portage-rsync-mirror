# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gensink/gensink-4.1-r1.ebuild,v 1.4 2014/08/10 20:57:47 slyfox Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Gensink ${PV}, a simple TCP benchmark suite"
HOMEPAGE="http://jes.home.cern.ch/jes/gensink/"
SRC_URI="http://jes.home.cern.ch/jes/gensink/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}/${P}-make.patch"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}
src_install() {
	dobin sink4 tub4 gen4
}
