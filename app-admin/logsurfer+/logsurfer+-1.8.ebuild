# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logsurfer+/logsurfer+-1.8.ebuild,v 1.3 2011/11/19 10:00:32 hwoarang Exp $

EAPI="4"
inherit toolchain-funcs

MY_P="logsurfer-${PV}"
DESCRIPTION="Real Time Log Monitoring and Alerting"
HOMEPAGE="http://www.crypt.gen.nz/logsurfer/"
SRC_URI="http://kerryt.orcon.net.nz/${MY_P}.tar.gz
	http://www.crypt.gen.nz/logsurfer/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf --with-etcdir=/etc
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin src/logsurfer
	doman man/logsurfer.1 man/logsurfer.conf.4

	newinitd "${FILESDIR}"/logsurfer.initd logsurfer
	newconfd "${FILESDIR}"/logsurfer.confd logsurfer
	dodoc ChangeLog README TODO
}
