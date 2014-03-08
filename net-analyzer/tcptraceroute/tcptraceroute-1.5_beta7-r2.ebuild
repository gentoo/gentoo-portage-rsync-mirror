# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.5_beta7-r2.ebuild,v 1.1 2014/03/08 17:34:50 jer Exp $

EAPI=5

MY_P=${P/_beta/beta}

DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
HOMEPAGE="https://github.com/mct/tcptraceroute"
SRC_URI="https://codeload.github.com/mct/${PN}/tar.gz/${MY_P} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"

DEPEND="
	net-libs/libnet
	net-libs/libpcap
"
RDEPEND="${DEPEND}"

# michael.toren.net is no longer available
RESTRICT="test"

S=${WORKDIR}/${PN}-${MY_P}

src_install() {
	dosbin tcptraceroute
	fowners root:wheel /usr/sbin/tcptraceroute
	fperms 4710 /usr/sbin/tcptraceroute
	doman tcptraceroute.1
	dodoc examples.txt README ChangeLog
	dohtml tcptraceroute.1.html
}
