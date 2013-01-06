# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/bbswitch/bbswitch-0.5.ebuild,v 1.1 2012/10/27 11:56:44 pacho Exp $

EAPI="4"
inherit linux-mod

DESCRIPTION="Toggle discrete NVIDIA Optimus graphics card"
HOMEPAGE="https://github.com/Bumblebee-Project/bbswitch"
SRC_URI="mirror://github/Bumblebee-Project/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/linux-sources
	sys-kernel/linux-headers"
RDEPEND=""

MODULE_NAMES="bbswitch(acpi)"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="default"
	BUILD_PARAMS="KVERSION=${KV_FULL}"
}

src_install() {
	insinto /etc/modprobe.d
	newins "${FILESDIR}"/bbswitch.modprobe bbswitch.conf
	dodoc NEWS

	linux-mod_src_install
}
