# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/batman-adv/batman-adv-2012.1.0.ebuild,v 1.1 2012/04/17 03:28:53 xmw Exp $

EAPI=4

CONFIG_CHECK="~!CONFIG_BATMAN_ADV"
MODULE_NAMES="${PN}(net:${S}:${S})"
BUILD_TARGETS="all"

inherit linux-mod

DESCRIPTION="Better approach to mobile Ad-Hoc networking on layer 2 kernel module"
HOMEPAGE="http://www.open-mesh.org/"
SRC_URI="http://downloads.open-mesh.org/batman/stable/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=""
RDEPEND=""

src_compile() {
	if use debug; then
		export BUILD_PARAMS="CONFIG_BATMAN_ADV_DEBUG=y"
	fi
	export KERNELPATH="${KERNEL_DIR}"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc README CHANGELOG
}
