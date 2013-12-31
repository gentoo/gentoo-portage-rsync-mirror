# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez/bluez-5.12.ebuild,v 1.1 2013/12/23 23:05:20 eva Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit eutils multilib python-any-r1 readme.gentoo systemd udev user

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://www.bluez.org"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.xz"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/3"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="cups debug obex readline selinux systemd test"
REQUIRED_USE="test? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	>=dev-libs/glib-2.28:2
	>=sys-apps/dbus-1.6:=
	>=sys-apps/hwids-20121202.2
	>=virtual/udev-171
	cups? ( net-print/cups:= )
	obex? ( dev-libs/libical )
	readline? ( sys-libs/readline:= )
	selinux? ( sec-policy/selinux-bluetooth )
	systemd? ( sys-apps/systemd )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? (
		${PYTHON_DEPS}
		>=dev-python/dbus-python-1
		dev-python/pygobject:2
		dev-python/pygobject:3
	)
"

DOC_CONTENTS="
	If you want to use rfcomm as a normal user, you need to add the user
	to the uucp group.
"

pkg_setup() {
	enewgroup plugdev
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	# Use static group "plugdev" if there is no ConsoleKit (or systemd logind)
	epatch "${FILESDIR}"/bluez-plugdev.patch

	if use cups; then
		sed -i \
			-e "s:cupsdir = \$(libdir)/cups:cupsdir = `cups-config --serverbin`:" \
			Makefile.{in,tools} || die
	fi
}

src_configure() {
	# readline is automagic when client is enabled
	export ac_cv_header_readline_readline_h=$(usex readline)

	# Missing flags: experimental (sap, nfc, ...)
	# Keep this in ./configure --help order!
	econf \
		--localstatedir=/var \
		--enable-optimization \
		$(use_enable debug) \
		--enable-pie \
		--enable-threads \
		--enable-library \
		$(use_enable test) \
		--enable-tools \
		--enable-monitor \
		--enable-udev \
		$(use_enable cups) \
		--enable-obex \
		--enable-client \
		$(use_enable systemd) \
		$(systemd_with_unitdir) \
		--enable-sixaxis
}

src_install() {
	default
	prune_libtool_files --modules

	keepdir /var/lib/bluetooth

	# Unittests are not that useful once installed
	if use test ; then
		rm -r "${ED}"/usr/$(get_libdir)/bluez/test || die
	fi

	insinto /etc/bluetooth
	local d
	for d in input network proximity; do
		doins profiles/${d}/${d}.conf
	done

	doins src/main.conf
	doins src/bluetooth.conf

	insinto /usr/share/dbus-1/system-services
	doins src/org.bluez.service

	newinitd "${FILESDIR}"/bluetooth-init.d-r3 bluetooth
	newinitd "${FILESDIR}"/rfcomm-init.d rfcomm
	newconfd "${FILESDIR}"/rfcomm-conf.d rfcomm

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog

	udev_reload

	has_version net-dialup/ppp || elog "To use dial up networking you must install net-dialup/ppp."

	if ! has_version sys-auth/consolekit && ! has_version sys-apps/systemd; then
		elog "Since you don't have sys-auth/consolekit neither sys-apps/systemd, you will only"
		elog "be able to run bluetooth clients as root. If you want to be able to run bluetooth clientes as"
		elog "a regular user, you need to enable the consolekit use flag for this package or"
		elog "to add the user to the plugdev group."
	fi
}
