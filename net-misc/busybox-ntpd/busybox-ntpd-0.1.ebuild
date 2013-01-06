# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/busybox-ntpd/busybox-ntpd-0.1.ebuild,v 1.1 2012/08/21 12:39:10 sbriesen Exp $

EAPI=4

HOMEPAGE="http://www.busybox.net/"
DESCRIPTION="Busybox ntpd symlink + init-script"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/busybox"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_setup() {
	local CNT=$(busybox --list | egrep -c '^(ntpd)$')
	if [ ${CNT} -ne 1 ]; then
		die "Missing busybox feature. You need at least 'ntpd'."
	fi
}

src_install() {
	dosym "../bin/busybox" "/sbin/ntpd"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
}
