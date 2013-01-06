# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-guest-agent/qemu-guest-agent-1.2.0.ebuild,v 1.2 2012/12/13 20:06:01 ssuominen Exp $

EAPI=4

inherit systemd udev

MY_PN="qemu"
MY_P="${MY_PN}-${PV}"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://git.qemu.org/qemu.git"
	inherit git-2
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://wiki.qemu.org/download/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
fi

DESCRIPTION="QEMU Guest Agent (qemu-ga) for use when running inside a VM"
HOMEPAGE="http://wiki.qemu.org/Features/QAPI/GuestAgent"

LICENSE="GPL-2 BSD-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/glib-2.22"
RDEPEND="${DEPEND}
	!<app-emulation/qemu-1.1.1-r1"

S="${WORKDIR}/${MY_P}"

src_configure() {
	./configure
}

src_compile() {
	emake qemu-ga
}

src_install() {
	dobin qemu-ga

	# Normal init stuff
	newinitd "${FILESDIR}/qemu-ga.init" qemu-guest-agent
	newconfd "${FILESDIR}/qemu-ga.conf" qemu-guest-agent

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/qemu-ga.logrotate" qemu-guest-agent

	# systemd stuff
	udev_newrules "${FILESDIR}/qemu-ga-systemd.udev" 99-qemu-guest-agent.rules

	systemd_newunit "${FILESDIR}/qemu-ga-systemd.service" \
		qemu-guest-agent.service
}

pkg_postinst() {
	elog "You should add 'qemu-guest-agent' to the default runlevel."
	elog "e.g. rc-update add qemu-guest-agent default"
}
