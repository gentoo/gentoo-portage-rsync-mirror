# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/phc-k8/phc-k8-0.4.2.ebuild,v 1.1 2010/08/24 13:37:14 xmw Exp $

EAPI=2

inherit linux-info linux-mod

DESCRIPTION="Processor Hardware Control for AMD K8 CPUs"
HOMEPAGE="http://www.linux-phc.org/"
SRC_URI="http://www.linux-phc.org/forum/download/file.php?id=83 -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}_v${PV}

CONFIG_CHECK="~!X86_POWERNOW_K8"
ERROR_X86_POWERNOW_K8="CONFIG_X86_POWERNOW_K8 should be configured to Module or Not set, to enable the replacemant of powernow-k8 with phc-k8."

MODULE_NAMES="phc-k8(misc:)"
BUILD_PARAMS="KERNELSRC=\"${KERNEL_DIR}\""
BUILD_TARGETS="all"

src_prepare() {
	if kernel_is -ge 2 6 33 ; then
		sed -i -e "s:include/linux/utsrelease.h:include/generated/utsrelease.h:" Makefile || die
	fi
}

src_install() {
	linux-mod_src_install
	dodoc Changelog README || die
}
