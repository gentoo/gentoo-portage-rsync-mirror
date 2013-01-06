# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spice-vdagent/spice-vdagent-0.12.0.ebuild,v 1.1 2012/10/04 17:08:40 cardoe Exp $

EAPI=4

inherit linux-info

DESCRIPTION="SPICE VD Linux Guest Agent."
HOMEPAGE="http://spice-space.org/"
SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+consolekit"

RDEPEND="x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libX11
	x11-libs/libXinerama
	>=x11-libs/libpciaccess-0.10
	>=app-emulation/spice-protocol-0.10.1
	consolekit? ( sys-auth/consolekit sys-apps/dbus )"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

CONFIG_CHECK="~INPUT_UINPUT ~VIRTIO_CONSOLE"
ERROR_INPUT_UINPUT="User level input support is required"
ERROR_VIRTIO_CONSOLE="VirtIO console/serial device support is required"

src_configure() {
	local opt=

	use consolekit && opt="${opt} --with-session-info=console-kit"

	econf \
		--localstatedir=/var \
		${opt}
}

src_install() {
	default

	rm -rf "${D}"/etc/{rc,tmpfiles}.d

	keepdir /var/run/spice-vdagentd
	keepdir /var/log/spice-vdagentd

	newinitd "${FILESDIR}/${PN}.initd-2" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd-2" "${PN}"
}
