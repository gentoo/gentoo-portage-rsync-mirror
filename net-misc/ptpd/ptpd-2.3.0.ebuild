# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils flag-o-matic systemd

DESCRIPTION="Precision Time Protocol daemon"
HOMEPAGE="http://ptpd.sf.net"

if [[ ${PV} == "9999" ]]; then
	ESVN_REPO_URI="http://svn.code.sf.net/p/ptpd/code/trunk"
	inherit subversion
	SRC_URI=""
	KEYWORDS=""
else
	if [[ ${PV} == *_rc* ]]; then
		MY_PV=${PV/_rc*/}
		MY_P=${P/_rc/-rc}
	else
		MY_PV=${PV}
		MY_P=${P}
	fi

	SRC_URI="mirror://sourceforge/ptpd/${MY_PV}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="BSD"
SLOT="0"
IUSE="snmp +statistics ntp experimental debug +daemon"
COMMON_DEPEND=" snmp? ( net-analyzer/net-snmp )
                ntp? ( net-misc/ntp )
                net-libs/libpcap"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
		cd "${S}"
		# QA
		epatch "${FILESDIR}/${P}-statistics-clear.patch"
		epatch "${FILESDIR}/${P}-ntpdc.patch"
	fi
}

src_prepare() { eautoreconf; }

src_configure() {
	append-flags -fno-strict-aliasing
	econf \
		$(use_enable snmp) \
		$(use_enable experimental experimental-options) \
		$(use_enable statistics) \
		$(use_enable ntp ntpdc) \
		$(use_enable debug runtime-debug) \
		$(use_enable daemon)
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"

	insinto /etc
	newins "${S}/src/ptpd2.conf.minimal" ptpd2.conf

	dodoc "${S}/src/ptpd2.conf.default-full"
	dodoc "${S}/src/ptpd2.conf.minimal"

	newinitd "${FILESDIR}/ptpd.rc" ptpd2
	newconfd "${FILESDIR}/ptpd.confd" ptpd2

	systemd_newunit "${FILESDIR}/ptpd.service" ptpd2.service
}

pkg_postinst() {
	elog "Do not forget to setup correct network interface."
	elog "Change the config file /etc/ptpd2.conf to suit your needs."
}
