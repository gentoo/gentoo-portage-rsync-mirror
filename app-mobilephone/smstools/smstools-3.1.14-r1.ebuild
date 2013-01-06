# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smstools/smstools-3.1.14-r1.ebuild,v 1.2 2012/06/02 05:02:33 zmedico Exp $

EAPI=4
inherit toolchain-funcs user

DESCRIPTION="Send and receive short messages through GSM modems"
HOMEPAGE="http://smstools3.kekekasvi.com/"
SRC_URI="http://smstools3.kekekasvi.com/packages/smstools3-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="stats"

DEPEND=""
RDEPEND="sys-process/procps
	stats? ( >=dev-libs/mm-1.4.0 )"

S="${WORKDIR}/${PN}3"

pkg_setup() {
	enewgroup sms
	enewuser smsd -1 -1 /var/spool/sms sms
}

src_prepare() {
	if use stats; then
		sed -i -e "s:CFLAGS += -D NOSTATS:#CFLAGS += -D NOSTATS:" \
			"${S}/src/Makefile"
	fi
}

src_compile() {
	cd src
	emake CC="$(tc-getCC)" LFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin src/smsd
	cd scripts
	dobin sendsms sms2html sms2unicode unicode2sms
	dobin hex2bin hex2dec email2sms
	dodoc mysmsd smsevent smsresend sms2xml sql_demo smstest.php
	dodoc checkhandler-utf-8 eventhandler-utf-8 forwardsms regular_run
	cd ..

	keepdir /var/spool/sms/incoming
	keepdir /var/spool/sms/outgoing
	keepdir /var/spool/sms/checked
	chown -R smsd:sms "${D}"/var/spool/sms
	chmod g+s "${D}"/var/spool/sms/incoming

	newinitd "${FILESDIR}"/smsd.initd2 smsd
	insopts -o smsd -g sms -m0644
	insinto /etc
	newins examples/smsd.conf.easy smsd.conf
	dohtml -r doc
}

pkg_postinst() {
	touch "${ROOT}"/var/log/smsd.log
	chown -f smsd:sms "${ROOT}"/var/log/smsd.log
}
