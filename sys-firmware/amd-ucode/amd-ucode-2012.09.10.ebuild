# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/amd-ucode/amd-ucode-2012.09.10.ebuild,v 1.1 2012/10/24 18:28:15 zerochaos Exp $

EAPI=4

inherit versionator linux-info

MY_P="${PN}-$(replace_all_version_separators -)"

DESCRIPTION="AMD Family 10h, 11h and 14h microcode patch data"
HOMEPAGE="http://www.amd64.org/support/microcode.html"
SRC_URI="http://www.amd64.org/pub/microcode/${MY_P}.tar"

LICENSE="amd-ucode"
SLOT="0"
IUSE=""

# only meaningful for x86 and x86-64
KEYWORDS="-* ~amd64 ~x86"

# The license does not allow us to mirror the content.
RESTRICT="mirror"

S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="~MICROCODE_AMD"
ERROR_MICROCODE_AMD="Your kernel needs to support AMD microcode loading. You're suggested to build it as a module as it doesn't require a reboot to reload the microcode, that way."

src_install() {
	insinto /lib/firmware/amd-ucode
	doins microcode_amd.bin microcode_amd_fam15h.bin

	# INSTALL file also has instructions to load it, so install it as
	# part of the documentation.
	dodoc README INSTALL
}

pkg_postinst() {
	local show_modules_info=yes
	local show_builtin_info=yes

	if linux_config_exists; then
		if linux_chkconfig_builtin MICROCODE; then
			show_modules_info=no
		elif linux_chkconfig_module MICROCODE; then
			show_builtin_info=no
		fi
	fi

	elog "You have installed the microcode for AMD CPUs. The kernel will load"
	elog "it the next time the microcode driver will be executed."
	elog ""

	if test $show_modules_info = yes; then
		elog "If you built the microcode driver as a module, you can issue the"
		elog "following command to force a reload:"
		elog ""
		elog "    modprobe -r microcode && modprobe microcode"
		elog ""
	fi

	if test $show_builtin_info = yes; then
		elog "If you built the microcode driver in the kernel, it won't load"
		elog "the file as is. To update the microcode you'll have to set the"
		elog "following configuration in the kernel:"
		elog ""
		elog "    CONFIG_EXTRA_FIRMWARE=\"amd-ucode/microcode_amd.bin amd-ucode/microcode_amd_fam15h.bin\""
		elog "    CONFIG_EXTRA_FIRMWARE_DIR=/lib/firmware"
		elog ""
		elog "Please note that this will build the firmware within the kernel"
		elog "image, so you'll have to rebuild the kernel after an upgrade"
		elog "of the ${CATEGORY}/${PN} package."
		elog ""
	fi
}
