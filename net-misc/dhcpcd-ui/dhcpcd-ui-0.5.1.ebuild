# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd-ui/dhcpcd-ui-0.5.1.ebuild,v 1.2 2011/02/05 16:34:01 ssuominen Exp $

EAPI=3
inherit eutils

DESCRIPTION="Desktop notification and configuration for dhcpcd"
HOMEPAGE="http://roy.marples.name/projects/dhcpcd-ui/"
SRC_URI="http://roy.marples.name/downloads/dhcpcd/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-libs/dhcpcd-dbus
	>=x11-libs/libnotify-0.4.4
	x11-libs/gtk+:2"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
}
