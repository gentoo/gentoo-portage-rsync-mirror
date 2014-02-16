# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdnssd/kdnssd-4.11.5.ebuild,v 1.4 2014/02/16 07:18:43 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="A DNSSD (DNS Service Discovery - part of Rendezvous) ioslave and kded module"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug zeroconf"

DEPEND="
	zeroconf? ( $(add_kdebase_dep kdelibs zeroconf) )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(-DWITH_Xmms=OFF -DWITH_DNSSD=ON)

	kde4-base_src_configure
}
