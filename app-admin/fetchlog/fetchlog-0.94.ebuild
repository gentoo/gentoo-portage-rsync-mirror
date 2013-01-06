# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fetchlog/fetchlog-0.94.ebuild,v 1.8 2007/01/24 14:13:55 genone Exp $

DESCRIPTION="Displays the last new messages of a logfile"
HOMEPAGE="http://fetchlog.sourceforge.net/"
SRC_URI="mirror://sourceforge/fetchlog/fetchlog-0.94.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

IUSE="snmp"

DEPEND="snmp? (
	>=dev-perl/Net-SNMP-4.0.1-r2
	>=net-analyzer/net-snmp-5.0.6
	)"

pkg_preinst() {
	elog
	elog "This utility can be used together with Nagios"
	elog "To make use of these features you need to"
	elog "install net-analyzer/nagios."
	elog "This feature depends on SNMP, so make use you"
	elog "have 'snmp' in your USE flags"
	elog
}

src_compile() {
	emake || die
}

src_install() {
	dodoc CHANGES README*
	dobin fetchlog
	doman fetchlog.1
}
