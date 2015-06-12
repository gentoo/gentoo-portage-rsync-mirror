# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils flag-o-matic systemd

DESCRIPTION="Precision Time Protocol daemon"
HOMEPAGE="http://ptpd.sf.net"

SRC_URI="mirror://sourceforge/ptpd/${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~arm"

LICENSE="BSD"
SLOT="0"
IUSE="snmp +statistics ntp experimental debug"
RDEPEND="snmp? ( net-analyzer/net-snmp )
	ntp? ( net-misc/ntp )
	net-libs/libpcap"
DEPEND="${RDEPEND}"

src_prepare() {
	# QA
	epatch "${FILESDIR}/${P}-statistics-clear.patch"
	epatch "${FILESDIR}/${P}-ntpdc.patch"

	eautoreconf
}

src_configure() {
	append-flags -fno-strict-aliasing
	econf \
		--enable-daemon \
		$(use_enable snmp) \
		$(use_enable experimental experimental-options) \
		$(use_enable statistics) \
		$(use_enable ntp ntpdc) \
		$(use_enable debug runtime-debug)
}

src_install() {
	emake install DESTDIR="${D}"

	insinto /etc
	newins "src/ptpd2.conf.minimal" ptpd2.conf

	dodoc "src/ptpd2.conf.default-full"
	dodoc "src/ptpd2.conf.minimal"

	newinitd "${FILESDIR}/ptpd2.rc" ptpd2
	newconfd "${FILESDIR}/ptpd2.confd" ptpd2

	systemd_dounit "${FILESDIR}/ptpd2.service"
}

pkg_postinst() {
	elog "Do not forget to setup correct network interface."
	elog "Change the config file /etc/ptpd2.conf to suit your needs."
}
