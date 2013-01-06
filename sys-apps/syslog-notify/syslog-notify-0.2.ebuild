# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syslog-notify/syslog-notify-0.2.ebuild,v 1.6 2012/11/21 10:11:26 ago Exp $

EAPI=4

DESCRIPTION="Notifications for syslog entries via libnotify"
HOMEPAGE="http://jtniehof.github.com/syslog-notify/"
SRC_URI="mirror://github/jtniehof/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=x11-libs/libnotify-0.7"
RDEPEND="${DEPEND}
	|| ( app-admin/syslog-ng app-admin/rsyslog )"

DOCS="AUTHORS CHANGELOG HACKING README"

src_install() {
	default
	dodir /var/spool
}

pkg_postinst() {
	mkfifo "${EROOT}"/var/spool/syslog-notify
}

pkg_postinst() {
	elog "Add the following options on your"
	elog "/etc/syslog-ng/syslog-ng.conf file:"
	elog "	#  destination notify { pipe("/var/spool/syslog-notify"); };"
	elog "	#  log { source(src); destination(notify);};"
	elog "Remember to restart syslog-ng before starting syslog-notify."
}
