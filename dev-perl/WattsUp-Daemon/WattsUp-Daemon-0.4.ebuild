# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WattsUp-Daemon/WattsUp-Daemon-0.4.ebuild,v 1.1 2007/12/02 10:08:01 robbat2 Exp $

inherit perl-module

DESCRIPTION="Watt's Up Monitoring Daemon"
HOMEPAGE="http://dev.gentoo.org/~robbat2/wattsup-daemon/"
SRC_URI="http://dev.gentoo.org/~robbat2/wattsup-daemon/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~ppc"

DEPEND="dev-perl/Device-SerialPort
		dev-perl/Time-TAI64
		virtual/perl-Time-HiRes"

mydoc="AUTHORS doc/wattsup_spec_v442.txt"
myconf="INSTALLSCRIPT=/usr/sbin/"

src_install() {
	perl-module_src_install
	cd "${S}"
	newinitd gentoo/wattsup-daemon.initd wattsup-daemon
	newconfd gentoo/wattsup-daemon.confd wattsup-daemon
}
