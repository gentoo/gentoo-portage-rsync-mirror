# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/psmon/psmon-1.39.ebuild,v 1.5 2013/07/31 21:44:27 vincent Exp $

inherit perl-app

DESCRIPTION="Monitors process table to slay aggressive, and spawn dead, processes"
HOMEPAGE="http://www.psmon.com/"
SRC_URI="http://www.psmon.com/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0
	dev-perl/config-general
	dev-perl/Proc-ProcessTable
	dev-perl/Unix-Syslog
	virtual/perl-Getopt-Long"
RDEPEND="${DEPEND}"

src_install() {
	perl-module_src_install
	insinto /etc
	doins etc/psmon.conf
}

pkg_postinst() {
	einfo "NOTICE: Please modify at least the NotifyEmail parameter found in"
	einfo "the /etc/psmon.conf file"
}
