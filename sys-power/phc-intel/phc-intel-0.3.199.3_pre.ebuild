# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/phc-intel/phc-intel-0.3.199.3_pre.ebuild,v 1.1 2010/08/24 00:51:14 xmw Exp $

EAPI=2

inherit linux-info linux-mod versionator

DESCRIPTION="Processor Hardware Control for Intel CPUs"
HOMEPAGE="http://www.linux-phc.org/"
SRC_URI="http://www.linux-phc.org/forum/download/file.php?id=86 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S=${WORKDIR}/test-release-$(replace_version_separator 3 '-' $(get_version_component_range 1-4))

CONFIG_CHECK="~!X86_ACPI_CPUFREQ"
ERROR_X86_ACPI_CPUFREQ="CONFIG_X86_ACPI_CPUFREQ has to be configured to Module or Not set to enable the replacement of acpi-cpufreq with phc-intel."

MODULE_NAMES="phc-intel(misc:)"
BUILD_PARAMS="KERNELSRC=\"${KERNEL_DIR}\" -j1"
BUILD_TARGETS="prepare all"

pkg_setup() {
	if ! kernel_is eq 2 6 31 ; then
		elog "This testrelease only supports kernel version 2.6.31."
		die
	fi
	elog "Please read /usr/share/doc/${PVF}/README carefully"
	elog "before updating your current config"
}

src_install() {
	linux-mod_src_install
	newdoc "READ BEFORE INSTALL" README || die
}
