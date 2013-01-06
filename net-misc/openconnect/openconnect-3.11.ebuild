# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openconnect/openconnect-3.11.ebuild,v 1.1 2011/08/16 09:15:47 dagger Exp $

EAPI=4

inherit eutils linux-info

DESCRIPTION="Free client for Cisco AnyConnect SSL VPN software"
HOMEPAGE="http://www.infradead.org/openconnect.html"
SRC_URI="ftp://ftp.infradead.org/pub/${PN}/${P}.tar.gz
		 http://dev.gentoo.org/~dagger/files/openconnect-script"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="dev-libs/openssl
	dev-libs/libxml2
	net-libs/libproxy"

RDEPEND="${DEPEND}
	 sys-apps/iproute2"

tun_tap_check() {
	ebegin "Checking for TUN/TAP support"
	if { ! linux_chkconfig_present TUN; }; then
		eerror "Please enable TUN/TAP support in your kernel config, found at:"
		eerror
		eerror "  Device Drivers  --->"
		eerror "    [*] Network device support  --->"
		eerror "      <*>   Universal TUN/TAP device driver support"
		eerror
		eerror "and recompile your kernel ..."
		die "no CONFIG_TUN support detected!"
	fi
	eend $?
}

pkg_setup() {
	if use kernel_linux; then
		get_version
		if linux_config_exists; then
			tun_tap_check
		else
			ewarn "Was unable to determine your kernel .config"
			ewarn "Please note that OpenConnect requires CONFIG_TUN to be set in your kernel .config, Without it, it will not work correctly."
			## We don't die here, so it's possible to compile this package without kernel sources available. Required for cross-compilation.
		fi
	fi
}

src_configure() {
	ECONF="$(use_enable static-libs static)"

	econf ${ECONF}
}

src_install() {
	emake DESTDIR="${D}" install || die "Faild to install"

	dodoc AUTHORS TODO
	dohtml ${PN}.html
	newinitd "${FILESDIR}"/openconnect.init.in openconnect
	dodir "/etc/openconnect"
	insinto "/etc/openconnect"
	newconfd "${FILESDIR}"/openconnect.conf.in openconnect
	exeinto "/etc/openconnect"
	newexe "${DISTDIR}/"openconnect-script openconnect.sh

	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} + || die "la file removal failed"
}
