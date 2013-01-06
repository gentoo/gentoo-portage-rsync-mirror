# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vmpsd/vmpsd-1.3-r4.ebuild,v 1.4 2009/09/23 19:47:57 patrick Exp $

inherit eutils flag-o-matic

DESCRIPTION="An open-source VLAN management system"
HOMEPAGE="http://vmps.sourceforge.net"
SRC_URI="mirror://sourceforge/vmps/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="net-analyzer/net-snmp
	dev-libs/openssl"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-snmp-support.patch
	epatch "${FILESDIR}"/${P}-64bit.patch
	EPATCH_OPTS="-d${S}" \
	epatch "${FILESDIR}"/${P}-format-sec.patch
}

src_compile() {
	econf \
		--sysconfdir=/etc/vmpsd \
		--enable-snmp \
		LIBS="-lssl" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README INSTALL AUTHORS doc/*txt
	newdoc external/README README.external
	newdoc tools/README README.tools
	dodoc external/simple tools/vqpcli.pl
}
