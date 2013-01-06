# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/misdn/misdn-1.1.7.2-r1.ebuild,v 1.2 2012/12/11 16:48:03 axs Exp $

inherit eutils linux-mod udev toolchain-funcs

MY_P=mISDN-${PV//./_}

DESCRIPTION="mISDN is the new ISDN stack of the linux kernel 2.6"
HOMEPAGE="http://www.misdn.org/"
SRC_URI="http://www.misdn.org/downloads/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="net-dialup/capi4k-utils
	dev-libs/libxslt
	sys-devel/bc"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# list of echo canceller use flags,
# first active in this list is selected (=order does matter)
MISDN_EC_FLAGS=("ecmg2" "eckb1" "ecmark2")

# list of card modules
MISDN_MODULES=("avmfritz"  "hfcpci" "hfcmulti" "hfcsusb" "hfcsmini" "xhfc" "sedlfax"  "w6692pci" "netjetpci")
MISDN_KCONFIG=("AVM_FRITZ" "HFCPCI" "HFCMULTI" "HFCUSB"  "HFCMINI"  "XHFC" "SPEEDFAX" "W6692"    "NETJET")

IUSE="ecaggressive ${MISDN_EC_FLAGS[*]}"
for i in ${MISDN_MODULES[@]}; do IUSE="${IUSE} misdn_cards_${i}"; done

MY_S=${WORKDIR}/${MY_P}
S=${MY_S}/drivers/isdn/hardware/mISDN

### Begin: Helper functions

select_echo_cancel() {
	local i myEC=${MISDN_EC_FLAGS[0]}
	for i in ${MISDN_EC_FLAGS[*]}; do
		if use ${i}; then
			myEC=$(echo "${i}" | sed -e "s:^ec\(.*\):\U\1\E:")
			break;
		fi
	done
	echo "${myEC}" | sed -e "s:^ec\(.*\):\U\1\E:"
}

dsp_enable() {
	local i
	for i in "${@}"; do
		sed -i -e "s:.*\(#include.*dsp_${i}\):\1:m" dsp.h
	done
}

dsp_disable() {
	local i
	for i in "${@}"; do
		sed -i -e "s:.*\(#include.*dsp_${i}\)://\1:m" dsp.h
	done
}

### End: Helper functions

#CONFIG_I4L_CAPI_LAYER -> I4LmISDN
#CONFIG_MISDN_MEMDEBUG -> memdbg
#CONFIG_MISDN_NETDEV -> netdev

# def SYSFS_SUPPORT

pkg_setup() {
	local USERCARD CARD EC NUM=0

	CONFIG_CHECK="ISDN_CAPI ISDN_CAPI_CAPI20 ISDN_CAPI_CAPIFS_BOOL"
	kernel_is ge 2 6 24 && CONFIG_CHECK="${CONFIG_CHECK} PCI_LEGACY"
	linux-mod_pkg_setup

	# base modules
	BUILD_TARGETS="modules"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} MINCLUDES=${MY_S}/include CONFIG_MISDN_DRV=m"
	MODULE_NAMES="mISDN_core(net:) mISDN_isac(net:) mISDN_l1(net:) mISDN_l2(net:)
			mISDN_x25dte(net:) l3udss1(net:) mISDN_capi(net:) mISDN_dtmf(net:)"

	# extra modules
	BUILD_PARAMS="${BUILD_PARAMS} CONFIG_MISDN_DSP=m CONFIG_MISDN_LOOP=m CONFIG_MISDN_DEBUGTOOL=m"
	MODULE_NAMES="${MODULE_NAMES} mISDN_dsp(net:) mISDN_loop(net:) mISDN_debugtool(net:)"

	# check if multiple echo cancellers have been selected
	EC_SELECTED=$(select_echo_cancel)
	for EC in ${MISDN_EC_FLAGS}; do
		use ${EC} && : $((NUM++))
	done
	if [ ${NUM} -gt 1 ]; then
		# multiple flags are active, only the first in the MISDN_EC_FLAGS
		# list will be used, make sure the user knows about this
		ewarn "Multiple echo canceller flags are active but only one will be used!"
		ewarn "Selected: ${EC_SELECTED}"
	else
		elog "Selected echo canceller: ${EC_SELECTED}"
	fi

	# Check existence of user selected cards
	if [ -n "${MISDN_CARDS}" ]; then
		for USERCARD in ${MISDN_CARDS}; do
			for ((CARD=0; CARD < ${#MISDN_MODULES[*]}; CARD++)); do
				if [ "${USERCARD}" = "${MISDN_MODULES[CARD]}" ]; then
					MODULE_NAMES="${MODULE_NAMES} ${MISDN_MODULES[CARD]}(net:)"
					BUILD_PARAMS="${BUILD_PARAMS} CONFIG_MISDN_${MISDN_KCONFIG[CARD]}=m"
					continue 2
				fi
			done
			die "Module ${USERCARD} not present in ${P}"
		done
	else
		elog "You can control the modules which are built with the variable"
		elog "MISDN_CARDS which should contain a blank separated list"
		elog "of a selection from the following cards:"
		elog "   ${MISDN_MODULES[*]}"
		# enable everything
		for ((CARD=0; CARD < ${#MISDN_MODULES[*]}; CARD++)); do
			MODULE_NAMES="${MODULE_NAMES} ${MISDN_MODULES[CARD]}(net:)"
			BUILD_PARAMS="${BUILD_PARAMS} CONFIG_MISDN_${MISDN_KCONFIG[CARD]}=m"
		done
	fi
}

src_unpack() {
	unpack ${A}

	# mostly backported from mISDN-git, so it should
	# not be needed anymore next version ;-)
	epatch "${FILESDIR}/misdn-2.6.24.diff"

	cd "${S}"
	sed -i -e "s:^\(CFLAGS\):EXTRA_\1:g" "Makefile"

	sed -i -e "s:^\(USER=\).*:\1root:" \
		-e "s:^\(GROUP=\).*:\1uucp:" \
		"${MY_S}/misdn-init"

	sed -i -e "s:^\(DEVNODE_user=\).*:\1'root':" \
		-e "s:^\(DEVNODE_group=\).*:\1'uucp':" \
		-e "s:^\(DEVNODE_mode=\).*:\1'0660':" \
		"${MY_S}/config/mISDN"

	if use ecaggressive; then
		sed -i -e "s:.*\(#define.*AGGRESSIVE_SUPPRESSOR\):\1:m" dsp.h
	fi

	case "${EC_SELECTED}" in
		MG2)
			dsp_enable  mg2ec
			dsp_disable kb1ec mec2
			;;
		KB1)
			dsp_enable  kb1ec
			dsp_disable mg2ec mec2
			;;
		MARK2)
			dsp_enable  mec2
			dsp_disable mg2ec kb1ec
			;;
	esac
}

src_install() {
	linux-mod_src_install

	insinto /usr/include/linux
	doins "${MY_S}/include/linux/"*.h

	local udevdir="$(udev_get_udevdir)"
	dodir "${udevdir}"/rules.d
	echo 'KERNEL=="obj-*", NAME="mISDN", GROUP="uucp", MODE="0660"' \
		> "${D}/${udevdir}"/rules.d/53-${PN}.rules

	insinto /etc/modprobe.d
	newins "${MY_S}/mISDN.modprobe.d" ${PN}
	dosbin "${MY_S}/misdn-init"
	dodoc "${MY_S}/README.misdn-init"

#	insinto /etc
#	doins "${MY_S}/config/mISDN.conf"
	insinto /usr/lib/mISDN
	doins "${MY_S}/config/"*.xsl
	dosbin "${MY_S}/config/mISDN"
	dodoc "${MY_S}/config/README.mISDN"

	dodoc Kconfig.v2.6 "${FILESDIR}/README.hfcmulti"
}

pkg_preinst() {
	# save old config, in case portage will remove it
	if [ -e "${ROOT}etc/misdn-init.conf" ]; then
		cp -pf "${ROOT}etc/misdn-init.conf" "${ROOT}etc/misdn-init.conf.pkginst"
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	# restore old config, in case portage removed it
	if [ -e "${ROOT}etc/misdn-init.conf.pkginst" ]; then
		if [ -e "${ROOT}etc/misdn-init.conf" ]; then
			rm -f "${ROOT}etc/misdn-init.conf.pkginst"
		else
			mv -f "${ROOT}etc/misdn-init.conf.pkginst" "${ROOT}etc/misdn-init.conf"
		fi
	fi

	ewarn
	ewarn "This driver is still under heavy development"
	ewarn "Please report ebuild related bugs / wishes to http://bugs.gentoo.org"
	ewarn "Please report driver bugs to the mISDN mailing-list:"
	ewarn "    https://www.isdn4linux.de/mailman/listinfo/isdn4linux"
}
