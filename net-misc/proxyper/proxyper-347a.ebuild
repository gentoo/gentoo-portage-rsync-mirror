# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxyper/proxyper-347a.ebuild,v 1.1 2013/03/28 12:22:44 tomwij Exp $

EAPI="5"

DESCRIPTION="distributed.net personal proxy"
HOMEPAGE="http://www.distributed.net"
SRC_URI="http://http.distributed.net/pub/dcti/${PN}/${PN}${PV}-linux-x86-uclibc.tar.gz"

LICENSE="distributed.net GPL-2"
SLOT="0"
KEYWORDS="-alpha -ppc -sparc ~x86"

RDEPEND="net-dns/host"

S=${WORKDIR}/${PN}${PV}-linux-x86-uclibc

RESTRICT="mirror"

QA_PRESTRIPPED="opt/proxyper/proxyper"

src_install() {
	local DESTDIR=/opt/proxyper
	exeinto ${DESTDIR}
	doexe proxyper

	# don't clobber an already existing ini file!
	insinto ${DESTDIR}
	if [ ! -f ${DESTDIR}/proxyper.ini ]
	then
		doins proxyper.ini
	else
		newins ${DESTDIR}/proxyper.ini proxyper.ini
	fi

	dodoc ChangeLog.txt
	dohtml manual.html

	newinitd "${FILESDIR}"/proxyper.init proxyper
}

pkg_postinst() {
	einfo "Don't forget to modify the config file"
	einfo "located in /opt/proxyper/proxyper.ini"
	einfo "It's recommend to reading the manual first :-)"
}

pkg_postrm() {
	local DESTDIR="/opt/proxyper"
	if [ -d ${DESTDIR} ]; then
		einfo "All files have not been removed from ${DESTDIR}"
	fi
}
