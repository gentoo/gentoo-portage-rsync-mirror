# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libvisual-projectm/libvisual-projectm-1.2.0.ebuild,v 1.3 2012/05/05 08:27:14 jdhore Exp $

inherit cmake-utils

MY_P=projectM-libvisual-${PV}

DESCRIPTION="A libvisual graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/libsdl
	=media-libs/libvisual-0.4*
	>=media-libs/libprojectm-1.1"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/cmake"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS ChangeLog"
