# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/cistronradius/cistronradius-1.6.8.ebuild,v 1.5 2014/08/10 20:55:30 slyfox Exp $

inherit eutils

DESCRIPTION="An authentication and accounting server for terminal servers that speak the RADIUS protocol"
SRC_URI="ftp://ftp.radius.cistron.nl/pub/radius/radiusd-cistron-${PV}.tar.gz"
HOMEPAGE="http://www.radius.cistron.nl/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="-* x86"

DEPEND="!net-dialup/freeradius
	!net-dialup/gnuradius"

S="${WORKDIR}/radiusd-cistron-${PV}/src"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc41.patch"
	sed -i -e "s:SHAREDIR/::g" ../raddb/dictionary
	mv checkrad.pl checkrad
}

src_compile() {
	emake \
	    CFLAGS="${CFLAGS}" LDFLAGS=${LDFLAGS} \
	    BINDIR=/usr/bin SBINDIR=/usr/sbin \
	    MANDIR=/usr/share/man SHAREDIR=/usr/share/radius \
	    || die "make failed"
}

src_install() {
	dodir /usr/sbin
	exeinto /usr/sbin
	doexe "${S}/checkrad"
	doexe "${S}/radiusd"
	doexe "${S}/radrelay"
	dodir /usr/bin
	exeinto /usr/bin
	doexe "${S}/radclient"
	doexe "${S}/radlast"
	doexe "${S}/radtest"
	doexe "${S}/radwho"
	doexe "${S}/radzap"

	newinitd "${FILESDIR}/cistronradius.rc" cistronradius

	cd "${S}/.."
	dodir /etc/raddb
	insinto /etc/raddb
	doins raddb/*
	dodoc COPYRIGHT README doc/{ChangeLog,FAQ.txt,README*}
	doman doc/{*.1,*.8,*.5rad,*.8rad}
}
