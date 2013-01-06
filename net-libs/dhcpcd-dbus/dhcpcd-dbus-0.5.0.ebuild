# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/dhcpcd-dbus/dhcpcd-dbus-0.5.0.ebuild,v 1.1 2010/06/12 21:32:34 darkside Exp $

EAPI=3

inherit eutils

DESCRIPTION="DBus bindings for dhcpcd"
HOMEPAGE="http://roy.marples.name/projects/dhcpcd-dbus/"
SRC_URI="http://roy.marples.name/downloads/dhcpcd/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=net-misc/dhcpcd-5.0
	sys-apps/dbus"
RDEPEND="${DEPEND}"

src_configure() {
	econf --localstatedir=/var
}

src_install() {
	emake DESTDIR="${D}" install
}
