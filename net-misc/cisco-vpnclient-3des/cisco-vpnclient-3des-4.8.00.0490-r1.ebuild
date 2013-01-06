# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cisco-vpnclient-3des/cisco-vpnclient-3des-4.8.00.0490-r1.ebuild,v 1.5 2012/07/12 15:33:59 axs Exp $

inherit eutils linux-mod

MY_PV=${PV}-k9
DESCRIPTION="Cisco VPN Client (3DES)"
HOMEPAGE="http://cco.cisco.com/en/US/products/sw/secursw/ps2308/index.html"
SRC_URI="vpnclient-linux-x86_64-${MY_PV}.tar.gz"

LICENSE="cisco-vpn-client GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="fetch strip" # stricter"

QA_TEXTRELS="opt/cisco-vpnclient/lib/libvpnapi.so"
QA_EXECSTACK="opt/cisco-vpnclient/lib/libvpnapi.so
	opt/cisco-vpnclient/bin/vpnclient
	opt/cisco-vpnclient/bin/cvpnd
	opt/cisco-vpnclient/bin/cisco_cert_mgr
	opt/cisco-vpnclient/bin/ipseclog"

S=${WORKDIR}/vpnclient

VPNDIR="/etc/opt/cisco-vpnclient/"

pkg_nofetch() {
	einfo "Please visit:"
	einfo " ${HOMEPAGE}"
	einfo "and download ${A} to ${DISTDIR}"
}

src_unpack () {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/2.6.22.patch
	epatch "${FILESDIR}"/2.6.24.patch
}

src_compile () {
	unset ARCH
	sh ./driver_build.sh ${KV_DIR}
	[ ! -f ./cisco_ipsec -a ! -f ./cisco_ipsec.ko ] \
		&& die "Failed to make module 'cisco_ipsec'"
	sed -i "s#@VPNBINDIR@#/usr/bin#" vpnclient_init
	sed -i "s#@VPNBINDIR@#/usr/bin#" vpnclient.ini
}

src_install() {
	newinitd "${FILESDIR}"/vpnclient.rc vpnclient

	exeinto /opt/cisco-vpnclient/bin
	exeopts -m0711
	doexe vpnclient
	exeopts -m4711
	doexe cvpnd
	into /opt/cisco-vpnclient/
	dobin ipseclog cisco_cert_mgr
	insinto /opt/cisco-vpnclient/lib
	doins libvpnapi.so
	insinto /opt/cisco-vpnclient/include
	doins vpnapi.h
	dodir /usr/bin
	dosym /opt/cisco-vpnclient/bin/vpnclient /usr/bin/vpnclient

	insinto /lib/modules/${KV}/CiscoVPN
	if kernel_is -ge 2 6; then
		doins cisco_ipsec.ko
	else
		doins cisco_ipsec
	fi

	insinto ${VPNDIR}
	doins vpnclient.ini
	insinto ${VPNDIR}/Profiles
	doins *.pcf
	dodir ${VPNDIR}/Certificates
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo "You must run \`/etc/init.d/vpnclient start\` before using the client."
	echo
	ewarn "Configuration directory has moved to ${VPNDIR}!"
	echo
}
