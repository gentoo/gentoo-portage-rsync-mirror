# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox-watchdog/busybox-watchdog-0.1.ebuild,v 1.1 2012/08/21 12:33:37 sbriesen Exp $

EAPI=4

HOMEPAGE="http://www.busybox.net/"
DESCRIPTION="Busybox watchdog symlink + init-script"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/busybox"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_setup() {
	local CNT=$(busybox --list | egrep -c '^(watchdog)$')
	if [ ${CNT} -ne 1 ]; then
		die "Missing busybox feature. You need at least 'watchdog'."
	fi
}

src_install() {
	dosym "../bin/busybox" "/sbin/watchdog"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
}
