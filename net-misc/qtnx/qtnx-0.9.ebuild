# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtnx/qtnx-0.9.ebuild,v 1.7 2013/03/02 23:05:56 hwoarang Exp $

EAPI="4"
inherit qt4-r2

MY_P="freenx-client-${PV}"

DESCRIPTION="A Qt-based NX client using nxcl"
HOMEPAGE="http://developer.berlios.de/projects/freenx/"
SRC_URI="mirror://berlios/freenx/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-misc/nxcl
	dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/${PN}"

src_prepare() {
	sed -i -e "s#id\.key#/usr/share/${PN}/id.key#" qtnxwindow.cpp || die "sed failed"
}

src_install() {
	dobin ${PN}
	dodoc README

	insinto /usr/share/${PN}
	doins id.key
}
