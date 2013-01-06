# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/fpdns/fpdns-0.9.1.ebuild,v 1.2 2010/02/05 22:40:58 ulm Exp $

DESCRIPTION="Fingerprinting DNS servers"
HOMEPAGE="http://www.rfc.se/fpdns/"
SRC_URI="http://www.rfc.se/fpdns/distfiles/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Net-DNS-0.42"

src_compile() { :; }

src_install() {
	newbin fpdns.pl fpdns
	doman fpdns.1
}
