# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/busybox-sysklogd/busybox-sysklogd-0.1.ebuild,v 1.2 2012/12/01 00:56:12 blueness Exp $

EAPI=4

HOMEPAGE="http://www.busybox.net/"
DESCRIPTION="Busybox syslogd/klogd/logread symlinks + init-script"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="sys-apps/busybox"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_setup() {
	local CNT=$(busybox --list | egrep -c '^(syslogd|klogd|logread)$')
	if [ ${CNT} -ne 3 ]; then
		die "Missing busybox feature. You need at least 'syslogd', 'klogd' and 'logread'."
	fi
}

src_install() {
	dosym "busybox" "/bin/logread"
	dosym "../bin/busybox" "/sbin/klogd"
	dosym "../bin/busybox" "/sbin/syslogd"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
}
