# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wakeonlan/wakeonlan-0.41-r2.ebuild,v 1.1 2014/05/26 15:05:35 jlec Exp $

EAPI=5

inherit eutils perl-app

DESCRIPTION="Client for Wake-On-LAN"
HOMEPAGE="http://gsd.di.uminho.pt/jpo/software/wakeonlan/"
SRC_URI="http://gsd.di.uminho.pt/jpo/software/wakeonlan/downloads/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE=""

DEPEND="virtual/perl-ExtUtils-MakeMaker"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-ethers-lookup.patch
}

src_install() {
	perl-module_src_install
	dodoc examples/lab001.wol
}
