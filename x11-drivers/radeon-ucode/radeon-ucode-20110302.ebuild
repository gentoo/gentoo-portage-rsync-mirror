# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/radeon-ucode/radeon-ucode-20110302.ebuild,v 1.3 2011/03/26 10:32:45 fauli Exp $

inherit linux-info

UCODE_BASE_URI="http://people.freedesktop.org/~agd5f/${PN/-/_}"
UCODE_FILES=(
	"BARTS_mc.bin"
	"BARTS_me.bin"
	"BARTS_pfp.bin"
	"BTC_rlc.bin"
	"CAICOS_mc.bin"
	"CAICOS_me.bin"
	"CAICOS_pfp.bin"
	"CAYMAN_mc.bin"
	"CAYMAN_me.bin"
	"CAYMAN_pfp.bin"
	"CAYMAN_rlc.bin"
	"CEDAR_me.bin"
	"CEDAR_pfp.bin"
	"CEDAR_rlc.bin"
	"CYPRESS_me.bin"
	"CYPRESS_pfp.bin"
	"CYPRESS_rlc.bin"
	"JUNIPER_me.bin"
	"JUNIPER_pfp.bin"
	"JUNIPER_rlc.bin"
	"R600_rlc.bin"
	"R700_rlc.bin"
	"PALM_me.bin"
	"PALM_pfp.bin"
	"REDWOOD_me.bin"
	"REDWOOD_pfp.bin"
	"REDWOOD_rlc.bin"
	"SUMO_rlc.bin"
	"TURKS_mc.bin"
	"TURKS_me.bin"
	"TURKS_pfp.bin"
)

DESCRIPTION="IRQ microcode for r6xx/r7xx/Evergreen Radeon GPUs"
HOMEPAGE="http://people.freedesktop.org/~agd5f/radeon_ucode/"
SRC_URI="${UCODE_FILES[@]/#/${UCODE_BASE_URI}/}"

LICENSE="radeon-ucode"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_unpack() { :; }

src_install() {
	insinto /lib/firmware/radeon || die "insinto failed"
	doins "${UCODE_FILES[@]/#/${DISTDIR}/}" || die "doins failed"
}

pkg_postinst() {
	if linux_config_exists && linux_chkconfig_builtin DRM_RADEON; then
		if ! linux_chkconfig_present FIRMWARE_IN_KERNEL || \
			! [[ "$(linux_chkconfig_string EXTRA_FIRMWARE)" == *_rlc.bin* ]]; then
			ewarn "Your kernel has radeon DRM built-in but not the IRQ microcode."
			ewarn "For kernel modesetting to work, please set in kernel config"
			ewarn "CONFIG_FIRMWARE_IN_KERNEL=y"
			ewarn "CONFIG_EXTRA_FIRMWARE_DIR=\"/lib/firmware\""
			ewarn "CONFIG_EXTRA_FIRMWARE=\"${UCODE_FILES[@]/#/radeon/}\""
			ewarn "You may skip microcode files for which no hardware is installed."
			ewarn "More information at http://wiki.x.org/wiki/radeonBuildHowTo"
		fi
	fi
}
