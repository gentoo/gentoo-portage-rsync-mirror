# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ltmodem/ltmodem-2.6.9-r1.ebuild,v 1.4 2009/03/13 20:25:17 mrness Exp $

inherit linux-mod eutils

MY_ALK_VER="${PV%.*}-alk-${PV##*.}"

DESCRIPTION="Winmodems with Lucent Apollo (ISA) and Mars (PCI) chipsets"
HOMEPAGE="http://linmodems.technion.ac.il/"
SRC_URI="http://linmodems.technion.ac.il/packages/ltmodem/kernel-2.6/ltmodem-${MY_ALK_VER}.tar.bz2"

LICENSE="GPL-2 AgereSystems-WinModem"
KEYWORDS="-* x86"
IUSE=""

RESTRICT="userpriv"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_ALK_VER}"

MODULE_NAMES="ltmodem(ltmodem:) ltserial(ltmodem:)"
MODULESD_LTMODEM_ALIASES=(
	"char-major-62 ltserial"
	"/dev/tts/LT0  ltserial"
	"/dev/modem ltserial"
)
CONFIG_CHECK="SERIAL_8250"
SERIAL_8250_ERROR="This driver requires you to compile your kernel with serial core (CONFIG_SERIAL_8250) support."

pkg_setup() {
	kernel_is ge 2 6 24 && CONFIG_CHECK="${CONFIG_CHECK} PCI_LEGACY"
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		eerror "This driver works only with 2.6 kernels!"
		die "unsupported kernel detected"
	fi

	BUILD_TARGETS="module"
	BUILD_PARAMS="KERNEL_DIR='${KV_DIR}'"
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-kernel-2.6.27.patch
}

src_install() {
	# Add configuration for udev
	insinto /etc/udev/rules.d/; newins "${FILESDIR}/ltmodem_udev" 55-ltmodem.rules

	# install kernel module
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if [ "$ROOT" = "/" ]; then
		/sbin/update-modules
	fi

	# Make some devices if we aren't using udev
	if [ -e "${ROOT}/dev/.udev" ]; then
		ebegin "Restarting udev to reread udev rules"
			udevadm control --reload-rules
		eend $?
	else
		mknod --mode=0660 /dev/ttySLTM0 c 62 64 && chgrp dialout /dev/ttySLTM0
	fi
	elog "Use /dev/ttySLTM0 to access modem"

	echo
	ewarn "Remember, in order to access the modem,"
	ewarn "you have to be in the 'dialout' group."
	ewarn "Also, if your dialing application use locking mechanism (e.g wvdial),"
	ewarn "you should have write access to /var/lock directory."

	if linux_chkconfig_present SMP ; then
		ewarn
		ewarn "Please note that Linux support for SMP (symmetric multi processor)"
		ewarn "is reported to be incompatible with this driver!"
		ewarn "In case it doesn't work, you should try first to disable CONFIG_SMP in your kernel."
	fi
}
