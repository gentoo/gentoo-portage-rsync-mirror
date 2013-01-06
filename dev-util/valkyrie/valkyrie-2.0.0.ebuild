# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valkyrie/valkyrie-2.0.0.ebuild,v 1.1 2010/11/11 01:28:22 xmw Exp $

EAPI=3

inherit qt4-r2

DESCRIPTION="Graphical front-end to the Valgrind suite of tools"
HOMEPAGE="http://www.valgrind.org/"
SRC_URI="http://www.valgrind.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/valgrind-3.6.0
	x11-libs/qt-gui:4
	x11-libs/qt-core:4"
RDEPEND="${DEPEND}"

DOCS=( README )
PATCHES=( "${FILESDIR}"/${P}-prefix.patch )
