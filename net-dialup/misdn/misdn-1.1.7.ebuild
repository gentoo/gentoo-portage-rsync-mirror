# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/misdn/misdn-1.1.7.ebuild,v 1.2 2008/03/27 17:36:28 genstef Exp $

inherit eutils linux-mod

MY_P=mISDN-${PV//./_}
DESCRIPTION="mISDN is the new ISDN stack of the linux kernel 2.6."
HOMEPAGE="http://www.misdn.org/"
SRC_URI="http://www.misdn.org/downloads/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

# list of echo canceller use flags,
# first active in this list is selected (=order does matter)
MISDN_EC_FLAGS="ecmg2 eckb1 ecmark2"

# list of card modules
MISDN_MODULES=("avmfritz" "hfcpci" "hfcmulti" "hfcsusb" "hfcsmini" "xhfc" "sedlfax" "w6692pci" "netjetpci")
MISDN_KCONFIG=("AVM_FRITZ" "HFCPCI" "HFCMULTI" "HFCUSB" "HFCMINI" "XHFC" "SPEEDFAX" "W6692" "NETJET")

IUSE="ecaggressive ${MISDN_EC_FLAGS}"
for i in ${MISDN_MODULES[@]}; do IUSE="${IUSE} misdn_cards_${i}"; done

RDEPEND=">=net-dialup/capi4k-utils-20050718
	sys-devel/bc"

S=${WORKDIR}/${MY_P}/drivers/isdn/hardware/mISDN

### Begin: Helper functions

select_echo_cancel() {
	local myEC=""
	for x in ${MISDN_EC_FLAGS}; do
		if use ${x}; then
			myEC=$(echo "${x}" | sed -e "s:^ec\(.*\):\U\1\E:")
			break;
		fi
	done
	echo ${myEC}
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

pkg_setup() {
	local numec=0

	CONFIG_CHECK="ISDN_CAPI ISDN_CAPI_CAPI20 ISDN_CAPI_CAPIFS_BOOL"
	linux-mod_pkg_setup
	MODULE_NAMES="mISDN_capi(net:) mISDN_dtmf(net:) mISDN_l1(net:)
	mISDN_x25dte(net:) l3udss1(net:) mISDN_core(net:) mISDN_isac(net:)
	mISDN_l2(net:) mISDN_dsp(net:)"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} MINCLUDES=${WORKDIR}/${MY_P}/include CONFIG_MISDN_DRV=m CONFIG_MISDN_DSP=y"
	BUILD_TARGETS="modules"
	#I4LmISDN(net:) does not compile :( CONFIG_I4L_CAPI_LAYER=m
	# the i4l->capi simulation seems to be only for kernel 2.4

	# check if multiple echo cancellers have been selected
	for x in ${MISDN_EC_FLAGS}; do
		use ${x} && : $((numec++))
	done
	if [[ ${numec} -gt 1 ]]; then
		# multiple flags are active, only the first in the ZAP_EC_FLAGS list
		# will be used, make sure the user knows about this
		ewarn
		ewarn "Multiple echo canceller flags are active but only one will be used!"
		ewarn "Selected: $(select_echo_cancel)"
	fi

	# Check existence of user selected cards
	if [ -n "${MISDN_CARDS}" ]; then
		for USERCARD in ${MISDN_CARDS} ; do
			for ((CARD=0; CARD < ${#MISDN_MODULES[*]}; CARD++)); do
				if [ "${USERCARD}" = "${MISDN_MODULES[CARD]}" ]; then
					MODULE_NAMES="${MODULE_NAMES} ${MISDN_MODULES[CARD]}(net:)"
					#[ "sedlfax" = "${MISDN_MODULES[CARD]}" ] && MODULE_NAMES="${MODULE_NAMES} faxl3(net:)"
					BUILD_PARAMS="${BUILD_PARAMS} CONFIG_MISDN_${MISDN_KCONFIG[CARD]}=y"
					continue 2
				fi
			done
			die "Module ${USERCARD} not present in ${P}"
		done
	else
		elog
		elog "You can control the modules which are built with the variable"
		elog "MISDN_CARDS which should contain a blank separated list"
		elog "of a selection from the following cards:"
		elog "   ${MISDN_MODULES[*]}"
		elog
		ewarn "I give you the chance of hitting Ctrl-C and make the necessary"
		ewarn "adjustments in /etc/make.conf."

		# enable everything
		for ((CARD=0; CARD < ${#MISDN_MODULES[*]}; CARD++)); do
			MODULE_NAMES="${MODULE_NAMES} ${MISDN_MODULES[CARD]}(net:)"
			#[ "sedlfax" = "${MISDN_MODULES[CARD]}" ] && MODULE_NAMES="${MODULE_NAMES} faxl3(net:)"
			BUILD_PARAMS="${BUILD_PARAMS} CONFIG_MISDN_${MISDN_KCONFIG[CARD]}=y"
		done
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	kernel_is ge 2 6 23 && epatch "${FILESDIR}"/misdn-2.6.23.diff

	if use ecaggressive; then
		sed -i -e "s:.*#define \(AGGRESSIVE_SUPPRESSOR\):#define \1:m" dsp.h
	fi

	case "$(select_echo_cancel)" in
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
	doins "${WORKDIR}/${MY_P}/"include/linux/*.h

	dodir /etc/udev/rules.d
	echo 'KERNEL=="obj-*", NAME="mISDN", GROUP="dialout", MODE="0660"' \
		> "${D}/etc/udev/rules.d/53-${PN}.rules"

	insinto /etc/modprobe.d
	newins "${WORKDIR}/${MY_P}/"mISDN.modprobe.d ${PN}

	sed -i -e "s:USER=.*:USER=root:" \
		-e "s:GROUP=.*:GROUP=dialout:" "${WORKDIR}/${MY_P}/"misdn-init
	dosbin "${WORKDIR}/${MY_P}/"misdn-init

	dodoc Kconfig.v2.6
	dodoc "${FILESDIR}/README.hfcmulti" "${WORKDIR}/${MY_P}/"README.misdn-init
}

pkg_preinst() {
	if [ -e "${ROOT}"/etc/misdn-init.conf ]; then
		cp "${ROOT}"/etc/misdn-init.conf "${D}"/etc
	else
		sed -i -e "s:/etc/misdn-init.conf:${D}\0:" "${D}"/usr/sbin/misdn-init
		"${D}"/usr/sbin/misdn-init config
		sed -i -e "s:${D}/etc/misdn-init.conf:/etc/misdn-init.conf:" "${D}"/usr/sbin/misdn-init
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn
	ewarn "This driver is still under heavy development"
	ewarn "Please report ebuild related bugs / wishes to http://bugs.gentoo.org"
	ewarn "Please report driver bugs to the mISDN mailing-list:"
	ewarn "    https://www.isdn4linux.de/mailman/listinfo/isdn4linux"
}
