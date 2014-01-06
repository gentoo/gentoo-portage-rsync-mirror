# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x2goclient/x2goclient-4.0.1.0.ebuild,v 1.5 2014/01/06 12:21:15 voyageur Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="The X2Go Qt client"
HOMEPAGE="http://www.x2go.org"
SRC_URI="http://code.x2go.org/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ldap"

DEPEND="net-libs/libssh
	net-print/cups
	dev-qt/qtcore:4[ssl]
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	ldap? ( net-nds/openldap )"
RDEPEND="${DEPEND}
	net-misc/nx"

src_prepare() {
	if ! use ldap; then
		sed -e "s/-lldap//" -i x2goclient.pro || die
		sed -e "s/#define USELDAP//" -i x2goclientconfig.h || die
	fi
}

src_install() {
	dobin ${PN}

	insinto /usr/share/pixmaps/x2goclient
	doins -r icons/*

	make_desktop_entry ${PN} "X2go client" ${PN} "Network"
}

pkg_postinst(){
	if has_version "<net-libs/libssh-0.6.0_rc1"; then
		ewarn "If x2goclient hangs at connect, you will need to either:"
		ewarn " * use >=net-libs/libssh-0.6.0_rc1 on the *client*"
		ewarn " * use net-misc/openssh[-hpn] on the *server*"
		ewarn "See bug #482548 for more information"
	fi
}
