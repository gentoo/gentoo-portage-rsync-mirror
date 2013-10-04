# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/connman/connman-1.15.ebuild,v 1.7 2013/10/04 04:04:13 phajdan.jr Exp $

EAPI="5"
inherit base systemd

DESCRIPTION="Provides a daemon for managing internet connections"
HOMEPAGE="http://connman.net"
SRC_URI="mirror://kernel/linux/network/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86"
IUSE="bluetooth debug doc examples +ethernet ofono openvpn policykit threads tools vpnc +wifi"

RDEPEND=">=dev-libs/glib-2.16
	>=sys-apps/dbus-1.2.24
	>=net-firewall/iptables-1.4.8
	net-libs/gnutls
	bluetooth? ( net-wireless/bluez )
	ofono? ( net-misc/ofono )
	policykit? ( sys-auth/polkit )
	openvpn? ( net-misc/openvpn )
	vpnc? ( net-misc/vpnc )
	wifi? ( >=net-wireless/wpa_supplicant-0.7[dbus] )"

DEPEND="${RDEPEND}
	>=sys-kernel/linux-headers-2.6.39
	doc? ( dev-util/gtk-doc )"

src_configure() {
	econf \
		--localstatedir=/var \
		--enable-client \
		--enable-datafiles \
		--enable-loopback=builtin \
		$(use_enable examples test) \
		$(use_enable ethernet ethernet builtin) \
		$(use_enable wifi wifi builtin) \
		$(use_enable bluetooth bluetooth builtin) \
		$(use_enable ofono ofono builtin) \
		$(use_enable openvpn openvpn builtin) \
		$(use_enable policykit polkit builtin) \
		$(use_enable vpnc vpnc builtin) \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_enable threads) \
		$(use_enable tools) \
		--disable-iospm \
		--disable-hh2serial-gps \
		--disable-openconnect
}

src_install() {
	emake DESTDIR="${D}" install
	dobin client/connmanctl || die "client installation failed"

	keepdir /var/lib/${PN}
	newinitd "${FILESDIR}"/${PN}.initd2 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	systemd_dounit "${FILESDIR}"/connman.service
}
