# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/cistronradius/cistronradius-1.6.8-r1.ebuild,v 1.2 2013/08/07 13:29:33 ago Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="An authentication and accounting server for terminal servers that speak the RADIUS protocol"
SRC_URI="ftp://ftp.radius.cistron.nl/pub/radius/radiusd-cistron-${PV}.tar.gz"
HOMEPAGE="http://www.radius.cistron.nl/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"

DEPEND="!net-dialup/freeradius
	!net-dialup/gnuradius"
RDEPEND="${DEPEND}"

S="${WORKDIR}/radiusd-cistron-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc41.patch"
	sed -i -e "s:SHAREDIR/::g" raddb/dictionary || die
	mv src/checkrad.pl src/checkrad || die

	epatch_user
}

src_compile() {
	emake -C src \
	    CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
	    BINDIR=/usr/bin SBINDIR=/usr/sbin \
	    MANDIR=/usr/share/man SHAREDIR=/usr/share/radius
}

src_install() {
	insinto /etc/raddb
	doins raddb/*
	dodoc README doc/{ChangeLog,FAQ.txt,README*}
	doman doc/{*.1,*.8,*.5rad,*.8rad}

	exeinto /usr/sbin
	doexe src/{checkrad,radiusd,radrelay}
	exeinto /usr/bin
	doexe src/{radclient,radlast,radtest,radwho,radzap}

	newinitd "${FILESDIR}/cistronradius.rc" cistronradius
}
