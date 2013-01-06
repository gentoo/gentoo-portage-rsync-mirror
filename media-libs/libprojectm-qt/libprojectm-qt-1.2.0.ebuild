# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libprojectm-qt/libprojectm-qt-1.2.0.ebuild,v 1.6 2012/07/26 16:01:41 kensington Exp $

EAPI=2

inherit cmake-utils

MY_TP=${P/m/M}
MY_P=${MY_TP%_p*}
MY_UP=${PN/m/M}-${PV/_p/-r}

DESCRIPTION="A graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_UP}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=media-libs/libprojectm-1.1
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

CMAKE_IN_SOURCE_BUILD=true
