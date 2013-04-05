# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpxy/udpxy-1.0.23.7.ebuild,v 1.1 2013/04/05 13:08:27 pinkbyte Exp $

EAPI="5"

inherit eutils toolchain-funcs versionator

MY_PV=$(replace_version_separator 3 -)
DESCRIPTION="small-footprint daemon to relay multicast UDP traffic to client's TCP (HTTP) connection"
HOMEPAGE="http://sourceforge.net/projects/udpxy/"
SRC_URI="http://www.udpxy.com/download/1_23/${PN}.${MY_PV}-prod.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	epatch_user
	tc-export CC
}

src_install() {
	dobin udpxy
	dosym udpxy /usr/bin/udpxrec

	doman doc/en/*.1
	dodoc CHANGES README

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
}
