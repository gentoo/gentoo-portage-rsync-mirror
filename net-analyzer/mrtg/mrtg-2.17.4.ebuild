# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mrtg/mrtg-2.17.4.ebuild,v 1.1 2012/02/04 21:26:38 radhermit Exp $

EAPI="4"

DESCRIPTION="A tool to monitor the traffic load on network-links"
HOMEPAGE="http://oss.oetiker.ch/mrtg/"
SRC_URI="http://oss.oetiker.ch/mrtg/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/SNMP_Session
	>=dev-perl/Socket6-0.20
	>=media-libs/gd-1.8.4"
RDEPEND="${DEPEND}"

src_prepare() {
	rm ./lib/mrtg2/{SNMP_{Session,util},BER}.pm || die
}

src_install () {
	keepdir /var/lib/mrtg

	emake DESTDIR="${ED}" install
	mv "${ED}/usr/share/doc/"{mrtg2,${PF}}

	newinitd "${FILESDIR}/mrtg.rc" ${PN}
	newconfd "${FILESDIR}/mrtg.confd" ${PN}
}

pkg_postinst(){
	elog "You must configure mrtg before being able to run it. Try cfgmaker."
	elog "The following thread may be useful:"
	elog "http://forums.gentoo.org/viewtopic-t-105862.html"
}
