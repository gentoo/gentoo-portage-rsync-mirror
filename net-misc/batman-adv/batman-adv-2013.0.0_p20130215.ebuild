# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/batman-adv/batman-adv-2013.0.0_p20130215.ebuild,v 1.1 2013/02/17 21:57:32 xmw Exp $

EAPI=4

MY_P=${PN}-2013.0.0
S=${WORKDIR}/${MY_P}
CONFIG_CHECK="~!CONFIG_BATMAN_ADV"
MODULE_NAMES="${PN}(net:${S}:${S})"
BUILD_TARGETS="all"

inherit base linux-mod

DESCRIPTION="Better approach to mobile Ad-Hoc networking on layer 2 kernel module"
HOMEPAGE="http://www.open-mesh.org/"
SRC_URI="http://downloads.open-mesh.org/batman/stable/sources/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bla dat debug"

DEPEND=""
RDEPEND=""

PATCHES=(
	"${FILESDIR}"/${MY_P}-0001-fix-skb-leak-in-batadv_dat_snoop_incoming.patch
	"${FILESDIR}"/${MY_P}-0002-check-for-more-types-of-invalid-IP-addres.patch
	"${FILESDIR}"/${MY_P}-0003-filter-ARP-packets-with-invalid-MAC-addre.patch
	"${FILESDIR}"/${MY_P}-0004-Fix-NULL-pointer-dereference-in-DAT-hash-.patch
)

src_compile() {
	BUILD_PARAMS="CONFIG_BATMAN_ADV_DEBUG=$(use debug && echo y || echo n)"
	BUILD_PARAMS+=" CONFIG_BATMAN_ADV_BLA=$(use bla && echo y || echo n)"
	BUILD_PARAMS+=" CONFIG_BATMAN_ADV_DAT=$(use dat && echo y || echo n)"
	export BUILD_PARAMS
	export KERNELPATH="${KERNEL_DIR}"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc README CHANGELOG
}
