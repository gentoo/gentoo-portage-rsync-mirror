# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ofono/ofono-1.10-r1.ebuild,v 1.1 2013/03/17 12:31:06 tomka Exp $

EAPI="5"

inherit eutils multilib systemd

DESCRIPTION="Open Source mobile telephony (GSM/UMTS) daemon."
HOMEPAGE="http://ofono.org/"
SRC_URI="mirror://kernel/linux/network/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+atmodem bluetooth +cdmamodem doc examples +isimodem +phonesim threads tools +udev"

RDEPEND=">=sys-apps/dbus-1.4
	>=dev-libs/glib-2.28
	net-misc/mobile-broadband-provider-info
	bluetooth? ( >=net-wireless/bluez-4.99 )
	udev? ( virtual/udev )
	examples? ( dev-python/dbus-python )
	tools? ( virtual/libusb:1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( ChangeLog AUTHORS )

src_prepare() {
	default
	epatch  "${FILESDIR}/${PN}-1.12-sys-types.patch"
}

src_configure() {
	econf \
		$(use_enable threads) \
		$(use_enable udev) \
		$(use_enable isimodem) \
		$(use_enable atmodem) \
		$(use_enable cdmamodem) \
		$(use_enable bluetooth) \
		$(use_enable phonesim) \
		$(use_enable tools) \
		--enable-test \
		--localstatedir=/var \
		--with-systemdunitdir="$(systemd_get_unitdir)"
}

src_install() {
	default

	if ! use examples ; then
		rm -rf "${D}/usr/$(get_libdir)/ofono/test" || die
	fi

	if use tools ; then
		dobin tools/{auto-enable,huawei-audio}
	fi

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	use doc && dodoc doc/*.txt
}
