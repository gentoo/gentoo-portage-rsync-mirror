# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/broadcom-sta/broadcom-sta-5.100.82.112-r3.ebuild,v 1.1 2013/05/12 10:50:32 pinkbyte Exp $

EAPI="5"
inherit eutils linux-mod

DESCRIPTION="Broadcom's IEEE 802.11a/b/g/n hybrid Linux device driver"
HOMEPAGE="http://www.broadcom.com/support/802.11/linux_sta.php"
SRC_BASE="http://www.broadcom.com/docs/linux_sta/hybrid-portsrc_x86_"
SRC_URI="x86? ( ${SRC_BASE}32-v${PV//\./_}.tar.gz )
	amd64? ( ${SRC_BASE}64-v${PV//\./_}.tar.gz )"

LICENSE="Broadcom"
KEYWORDS="-* ~amd64 ~x86"

DEPEND="virtual/linux-sources"
RDEPEND=""

RESTRICT="mirror"

S="${WORKDIR}"

MODULE_NAMES="wl(net/wireless)"
MODULESD_WL_ALIASES=("wlan0 wl")

pkg_setup() {
	# bug #300570
	# NOTE<lxnay>: module builds correctly anyway with b43 and SSB enabled
	# make checks non-fatal. The correct fix is blackisting ssb and, perhaps
	# b43 via udev rules. Moreover, previous fix broke binpkgs support.
	CONFIG_CHECK="~!B43 ~!SSB"
	CONFIG_CHECK2="LIB80211 ~!MAC80211 ~LIB80211_CRYPT_TKIP"
	ERROR_B43="B43: If you insist on building this, you must blacklist it!"
	ERROR_SSB="SSB: If you insist on building this, you must blacklist it!"
	ERROR_LIB80211="LIB80211: Please enable it. If you can't find it: enabling the driver for \"Intel PRO/Wireless 2100\" or \"Intel PRO/Wireless 2200BG\" (IPW2100 or IPW2200) should suffice."
	ERROR_MAC80211="MAC80211: If you insist on building this, you must blacklist it!"
	ERROR_PREEMPT_RCU="PREEMPT_RCU: Please do not set the Preemption Model to \"Preemptible Kernel\"; choose something else."
	ERROR_LIB80211_CRYPT_TKIP="LIB80211_CRYPT_TKIP: You will need this for WPA."
	if kernel_is ge 2 6 32; then
		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} CFG80211"
	elif kernel_is ge 2 6 31; then
		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} WIRELESS_EXT ~!MAC80211"
	elif kernel_is ge 2 6 29; then
		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} WIRELESS_EXT COMPAT_NET_DEV_OPS"
	else
		CONFIG_CHECK="${CONFIG_CHECK} IEEE80211 IEEE80211_CRYPT_TKIP"
	fi

	linux-mod_pkg_setup

	BUILD_PARAMS="-C ${KV_DIR} M=${S}"
	if kernel_is ge 3 6 0; then
		BUILD_PARAMS="${BUILD_PARAMS} API=WEXT"
		CONFIG_CHECK="${CONFIG_CHECK} WIRELESS_EXT"
	fi
	BUILD_TARGETS="wl.ko"
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-5.10.91.9-license.patch" \
		"${FILESDIR}/${PN}-5.100.82.38-gcc.patch" \
		"${FILESDIR}/${PN}-5.100.82.111-linux-3.0.patch" \
		"${FILESDIR}/${P}-linux-2.6.39.patch" \
		"${FILESDIR}/${P}-linux-3.2-with-multicast.patch" \
		"${FILESDIR}/${P}-linux-3.4.patch" \
		"${FILESDIR}/${P}-linux-3.6.patch" \
		"${FILESDIR}/${P}-linux-3.8.patch" \
		"${FILESDIR}/${P}-linux-3.9.patch" \
		"${FILESDIR}/${P}-remove-rssi-errors.patch"

	epatch_user
}
