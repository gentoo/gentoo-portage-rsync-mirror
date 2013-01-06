# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/rtkit/rtkit-0.10.ebuild,v 1.10 2012/10/16 16:00:01 jer Exp $

EAPI="4"

inherit eutils systemd user

DESCRIPTION="Realtime Policy and Watchdog Daemon"
HOMEPAGE="http://0pointer.de/blog/projects/rtkit"
SRC_URI="http://0pointer.de/public/${P}.tar.gz"

LICENSE="GPL-3 BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="sys-apps/dbus
	sys-auth/polkit
	sys-libs/libcap"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup rtkit
	enewuser rtkit -1 -1 -1 "rtkit"
}

src_configure() {
	econf $(systemd_with_unitdir)
}

src_install() {
	emake DESTDIR="${D}" install

	./rtkit-daemon --introspect > org.freedesktop.RealtimeKit1.xml
	insinto /usr/share/dbus-1/interfaces
	doins org.freedesktop.RealtimeKit1.xml
}

pkg_postinst () {
	einfo "To start using RealtimeKit, you need to ensure that the 'dbus'"
	einfo "service is running. If it is already running, you need to reload it"
	einfo "with the following command:"
	einfo ""
	einfo "    /etc/init.d/dbus reload"
}
