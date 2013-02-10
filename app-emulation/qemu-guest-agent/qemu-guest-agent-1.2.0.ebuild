# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-guest-agent/qemu-guest-agent-1.2.0.ebuild,v 1.3 2013/02/10 21:47:50 cardoe Exp $

EAPI=4

inherit systemd udev python

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
PYTHON_DEPEND="2:2.4"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	./configure --python=python2
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
