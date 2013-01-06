# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gensink/gensink-4.1.ebuild,v 1.8 2012/12/27 08:07:33 armin76 Exp $

DESCRIPTION="Gensink ${PV}, a simple TCP benchmark suite."
HOMEPAGE="http://jes.home.cern.ch/jes/gensink/"
SRC_URI="http://jes.home.cern.ch/jes/gensink/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
DEPEND=""

src_compile() {
	make || die
}

src_install() {
	exeinto /usr/bin
	doexe sink4 tub4 gen4
}
