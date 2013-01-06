# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basqet/basqet-0.2.0.ebuild,v 1.1 2012/05/08 21:34:02 kensington Exp $

EAPI=4

inherit qt4-r2

DESCRIPTION="Keep your notes, pictures, ideas, and information in Baskets"
HOMEPAGE="http://code.google.com/p/basqet/"
SRC_URI="http://basqet.googlecode.com/files/${PN}_${PV}-src.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/release_${PV}

PATCHES=( "${FILESDIR}/${P}-desktop.patch" )

src_prepare() {
	qt4-r2_src_prepare

	sed -i 's:PREFIX = /usr/local:PREFIX = /usr:' ${PN}.pro || die
}
