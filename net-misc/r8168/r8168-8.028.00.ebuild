# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/r8168/r8168-8.028.00.ebuild,v 1.4 2012/04/05 21:12:07 phajdan.jr Exp $

EAPI=4

inherit linux-mod eutils

DESCRIPTION="r8168 driver for Realtek 8111/8168 PCI-E NICs"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="http://r8168.googlecode.com/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="amd64 x86"

MODULE_NAMES="r8168(net:${S}/src)"
BUILD_TARGETS="modules"
CONFIG_CHECK="!R8169"

ERROR_R8169="${P} requires Realtek 8169 PCI Gigabit Ethernet adapter (CONFIG_R8169) to be DISABLED"

src_prepare() {
	epatch "${FILESDIR}/${P}-linux-3.3-compat.patch"
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_install() {
	linux-mod_src_install
	dodoc README
}
