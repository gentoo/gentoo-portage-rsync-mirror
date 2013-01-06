# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpon/arpon-2.7-r1.ebuild,v 1.4 2012/06/08 12:03:27 phajdan.jr Exp $

EAPI="4"
inherit cmake-utils

DESCRIPTION="ArpON (Arp handler inspectiON) is a portable Arp handler."

MY_PN="ArpON"
MY_P="${MY_PN}-${PV}"
HOMEPAGE="http://arpon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/libdnet
	net-libs/libnet:1.1
	net-libs/libpcap"

RDEPEND=${DEPEND}

S="${WORKDIR}"/${MY_P}

src_prepare() {
	sed -i -e "/set(CMAKE_C_FLAGS/d" CMakeLists.txt || die
}

src_install() {
	cmake-utils_src_install
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}

pkg_postinst() {
	elog
	elog "${PN} now installs an init script. Please edit"
	elog "the /etc/conf.d/arpon file to match your needs"
	elog
}
