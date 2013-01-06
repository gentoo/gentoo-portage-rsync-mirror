# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logsurfer+/logsurfer+-1.7.ebuild,v 1.2 2008/10/24 21:07:35 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="Real Time Log Monitoring and Alerting"
HOMEPAGE="http://www.crypt.gen.nz/logsurfer/"
SRC_URI="http://kerryt.orcon.net.nz/${P}.tar.gz
	http://www.crypt.gen.nz/logsurfer/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_compile() {
	econf --with-etcdir=/etc || die
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin src/logsurfer || die
	doman man/logsurfer.1 man/logsurfer.conf.4 || die

	newinitd "${FILESDIR}"/logsurfer.initd logsurfer || die
	newconfd "${FILESDIR}"/logsurfer.confd logsurfer || die
	dodoc ChangeLog README TODO
	docinto config-examples
	dodoc config-examples/*
}
