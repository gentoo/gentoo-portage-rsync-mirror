# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/phc-intel/phc-intel-0.3.2.12.1-r3.ebuild,v 1.3 2012/05/24 05:47:16 vapier Exp $

EAPI=2

inherit linux-info linux-mod versionator eutils

DESCRIPTION="Processor Hardware Control for Intel CPUs"
HOMEPAGE="http://www.linux-phc.org/"
SRC_URI="http://www.linux-phc.org/forum/download/file.php?id=94 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-$(replace_version_separator 3 '-' $(replace_version_separator 4 '-'))

CONFIG_CHECK="~!X86_ACPI_CPUFREQ"
ERROR_X86_ACPI_CPUFREQ="CONFIG_X86_ACPI_CPUFREQ has to be configured to Module to enable the replacement of acpi-cpufreq with phc-intel."

MODULE_NAMES="phc-intel(misc:)"
BUILD_PARAMS="KERNELSRC=\"${KERNEL_DIR}\" -j1"
BUILD_TARGETS="all"

pkg_setup() {
	if kernel_is lt 2 6 33 ; then
		eerror "Your kernel version is no longer supported by this version of ${PN}."
		eerror "Please use a previous version of ${PN} or a newer kernel."
		die
	fi
	linux-mod_pkg_setup
}

src_prepare() {
	sed -e '/^all:/s:prepare::' \
		-e '/error Only support for 2.6 series kernels/d' \
		-i Makefile || die

	local my_sub=arch/x86/kernel/cpu
	if kernel_is gt 2 6 39 ; then
		my_sub=drivers
	fi
	cp -v "${KERNEL_DIR}"/${my_sub}/cpufreq/acpi-cpufreq.c phc-intel.c || die
	cp -v "${KERNEL_DIR}"/${my_sub}/cpufreq/mperf.h . || die

	if kernel_is eq 2 6 35 || kernel_is eq 2 6 36 ; then
		epatch "${FILESDIR}"/${P}-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}.patch
	else
		epatch "${FILESDIR}"/${P}-2.6.37.patch
	fi
}

src_install() {
	linux-mod_src_install
	dodoc README || die
}
