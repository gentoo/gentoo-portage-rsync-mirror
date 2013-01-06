# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smsclient/smsclient-2.0.9a-r1.ebuild,v 1.3 2008/11/02 18:57:14 mrness Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Utility to send SMS messages to mobile phones and pagers."
HOMEPAGE="http://www.smsclient.org"
SRC_URI="http://www.smsclient.org/download/${PN}-${PV%?}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-sender.patch"
}

src_compile() {
	rm .configured && ./configure || die "Configure failed"
	emake CC="$(tc-getCC)" || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dosym sms_client /usr/bin/smsclient
	dosym sms_address /usr/bin/smsaddress

	diropts -g dialout -m 0770
	keepdir /var/lock/sms
	diropts

	doman docs/sms_client.1
	dodoc Authors Changelog* FAQ README* TODO docs/sms_protocol
}

pkg_postinst() {
	local MY_LOGFILE="${ROOT}/var/log/smsclient.log"
	[ -f "${MY_LOGFILE}" ] || touch "${MY_LOGFILE}"
	chgrp dialout "${MY_LOGFILE}"
	chmod g+rwx,o-rwx "${MY_LOGFILE}"

	einfo "If you run sms_client as normal user, make sure you are member of dialout group."
}
