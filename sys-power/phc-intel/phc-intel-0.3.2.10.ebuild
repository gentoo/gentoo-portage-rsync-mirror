# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/phc-intel/phc-intel-0.3.2.10.ebuild,v 1.1 2010/08/24 00:51:14 xmw Exp $

EAPI=2

inherit linux-info linux-mod

DESCRIPTION="Processor Hardware Control for Intel CPUs"
HOMEPAGE="http://www.linux-phc.org/"
SRC_URI="http://www.linux-phc.org/forum/download/file.php?id=87 -> ${P}.tar.bz2 "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${P%.*}-${P##*.}"

CONFIG_CHECK="~!X86_ACPI_CPUFREQ"
ERROR_X86_ACPI_CPUFREQ="CONFIG_X86_ACPI_CPUFREQ has to be configured to Module or Not set to enable the replacement of acpi-cpufreq with phc-intel."

MODULE_NAMES="phc-intel(misc:)"
BUILD_PARAMS="KERNELSRC=\"${KERNEL_DIR}\""
BUILD_TARGETS="prepare all"

pkg_setup() {
	if kernel_is gt 2 6 32 ; then
		eerror "Your kernel version is not supported by this version of ${PN}."
		eerror "Please use a newer version for kernels 2.6.33 and above."
		die
	fi
}

src_install() {
	linux-mod_src_install
	dodoc README || die
}
