# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnswalk/dnswalk-2.0.2.ebuild,v 1.17 2012/08/06 01:18:44 ottxor Exp $

EAPI=4

S=${WORKDIR}
DESCRIPTION="dnswalk is a DNS database debugger"
SRC_URI="mirror://sourceforge/dnswalk/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/dnswalk/"

DEPEND=">=dev-perl/Net-DNS-0.12"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 ppc sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

src_prepare() {
	sed -i 's:#!/usr/contrib/bin/perl:#!'"${EPREFIX}"'/usr/bin/perl:' dnswalk
}

src_install () {
	dobin dnswalk

	dodoc CHANGES README TODO \
		do-dnswalk makereports sendreports rfc1912.txt dnswalk.errors
	doman dnswalk.1
}
