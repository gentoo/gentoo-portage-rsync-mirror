# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/usbip/usbip-3.6.ebuild,v 1.2 2012/11/19 04:08:53 ssuominen Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Userspace utilities for a general USB device sharing system over IP networks"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="mirror://kernel/linux/kernel/v${PV%.*}.0/linux-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs tcpd"

RDEPEND=">=dev-libs/glib-2.6
	sys-apps/hwids
	>=sys-fs/sysfsutils-2
	tcpd? ( sys-apps/tcp-wrappers )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS README ../usbip_protocol.txt"

S=${WORKDIR}/linux-${PV}/drivers/staging/${PN}/userspace

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use tcpd || echo --without-tcp-wrappers) \
		--with-usbids-dir=/usr/share/misc
}

src_install() {
	default
	prune_libtool_files
}

pkg_postinst() {
	elog "For using USB/IP you need to enable USB_IP_VHCI_HCD in the client"
	elog "machine's kernel config and USB_IP_HOST on the server."
}
