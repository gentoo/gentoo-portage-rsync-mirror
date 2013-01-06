# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/connman-gnome/connman-gnome-0.5.ebuild,v 1.3 2011/03/29 12:20:45 angelos Exp $

EAPI="2"

DESCRIPTION="Provides a daemon for managing internet connections"
HOMEPAGE="http://connman.net"
SRC_URI="mirror://kernel/linux/network/connman/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16
	>=sys-apps/dbus-1.2
	>=dev-libs/dbus-glib-0.73
	>=x11-libs/gtk+-2.10:2
	net-misc/connman"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
