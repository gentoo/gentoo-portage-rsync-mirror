# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_misdn/asterisk-chan_misdn-0.3.0.ebuild,v 1.2 2008/10/04 01:24:56 darkside Exp $

MY_PN=${PN/asterisk-}
DESCRIPTION="Asterisk channel plugin for mISDN"
HOMEPAGE="http://www.beronet.com/"
SRC_URI="http://www.beronet.com/downloads/chan_misdn/releases/V${PV:0:3}/${MY_PN}-${PV/_/-}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=net-dialup/misdnuser-0.1_pre20060307
	>=net-misc/asterisk-1.2"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -ir "s:.*MISDNUSERLIB.*::" Makefile || die "sed failed"
}

src_install() {
	exeinto /usr/lib/asterisk/modules
	doexe chan_misdn.so
	insinto /etc/asterisk
	doins misdn.conf

	dodoc README README.misdn
}
