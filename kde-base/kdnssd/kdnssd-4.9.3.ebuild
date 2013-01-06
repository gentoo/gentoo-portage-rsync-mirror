# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdnssd/kdnssd-4.9.3.ebuild,v 1.4 2012/11/30 15:51:26 ago Exp $

EAPI=4

KMNAME="kdenetwork"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="A DNSSD (DNS Service Discovery - part of Rendezvous) ioslave and kded module"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug zeroconf"

DEPEND="
	zeroconf? ( $(add_kdebase_dep kdelibs zeroconf) )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(-DWITH_Xmms=OFF -DWITH_DNSSD=ON)

	kde4-meta_src_configure
}
