# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ippl/ippl-1.4.14-r1.ebuild,v 1.6 2012/10/12 10:46:15 pinkbyte Exp $

inherit eutils user

DESCRIPTION="A daemon which logs TCP/UDP/ICMP packets"
HOMEPAGE="http://pltplp.net/ippl/"
SRC_URI="http://pltplp.net/ippl/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/yacc
	>=sys-devel/flex-2.5.4a-r4"
RDEPEND=""

pkg_setup() {
	enewuser ippl
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patches from debian which besides features additions fix some bugs...
	epatch "${FILESDIR}"/ippl-1.4.14-noportresolve.patch
	epatch "${FILESDIR}"/ippl-1.4.14-manpage.patch
	epatch "${FILESDIR}"/ippl-1.4.14-privilege-drop.patch
}

src_install() {
	dosbin Source/ippl

	insinto "/etc"
	doins ippl.conf

	doman Docs/{ippl.8,ippl.conf.5}

	dodoc BUGS CREDITS HISTORY README TODO

	newinitd "${FILESDIR}"/ippl.rc ippl
}
