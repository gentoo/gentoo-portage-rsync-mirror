# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qxkb/qxkb-0.4.4-r1.ebuild,v 1.1 2012/09/13 09:52:32 yngwin Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Qt4-based keyboard layout switcher"
HOMEPAGE="http://code.google.com/p/qxkb/"
SRC_URI="http://qxkb.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="x11-libs/libxkbfile
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4"
RDEPEND="${DEPEND}
	x11-apps/setxkbmap"
