# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-guest-agent/qemu-guest-agent-1.1.1.ebuild,v 1.4 2012/12/13 20:06:01 ssuominen Exp $

EAPI=4

inherit systemd udev

MY_PN="qemu-kvm"
MY_P="${MY_PN}-${PV}"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/virt/kvm/qemu-kvm.git"
	inherit git-2
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/kvm/${MY_PN}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
fi

DESCRIPTION="QEMU Guest Agent (qemu-ga) for use when running inside a VM"
HOMEPAGE="http://wiki.qemu.org/Features/QAPI/GuestAgent"

LICENSE="GPL-2 BSD-2"
SLOT="0"
IUSE="systemd"

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

	if ! use systemd; then
		# Normal init stuff
		newinitd "${FILESDIR}/qemu-ga.init" qemu-guest-agent
		newconfd "${FILESDIR}/qemu-ga.conf" qemu-guest-agent

		insinto /etc/logrotate.d/
		newins "${FILESDIR}/qemu-ga.logrotate" qemu-guest-agent
	else
		# systemd stuff
		udev_newrules "${FILESDIR}/qemu-ga-systemd.udev" 99-qemu-guest-agent.rules

		systemd_newunit "${FILESDIR}/qemu-ga-systemd.service" \
			qemu-guest-agent.service
	fi
}

pkg_postinst() {
	if ! use systemd; then
		elog "You should add 'qemu-guest-agent' to the default runlevel."
		elog "e.g. rc-update add qemu-guest-agent default"
	fi
}
