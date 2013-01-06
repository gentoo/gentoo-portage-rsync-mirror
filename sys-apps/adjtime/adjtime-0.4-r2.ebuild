# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/adjtime/adjtime-0.4-r2.ebuild,v 1.3 2007/07/12 05:10:21 mr_bones_ Exp $

DESCRIPTION="A perl script to adjust the clock tick of the hardware clock on the system board (should work on most platforms)."
HOMEPAGE="http://groups.yahoo.com/group/LinkStation_General/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

RDEPEND="dev-lang/perl
	>=net-misc/ntp-4.2"

src_install() {
	dodir /usr/sbin
	dosbin ${FILESDIR}/adjtime.pl || die
}

pkg_postinst() {
	ewarn "There have been issues with running adjtime as an init script"
	ewarn "(the shell environment for perl is dorked up).  The suggested"
	ewarn "method is to use ntp-date rather than ntpd at startup, and"
	ewarn "add the following two lines to local.start instead:"
	ewarn
	ewarn "/usr/bin/perl /usr/sbin/adjtime.pl -v -s ntp_host -i 60"
	ewarn
	ewarn "/etc/init.d/ntpd start"
	ewarn
	ewarn "replacing ntp_host with your preferred ntp server.  Remember,"
	ewarn "since adjtime uses ntp-date, ntpd must be stopped (or not yet"
	ewarn "started) prior to running the adjtime script."
}
