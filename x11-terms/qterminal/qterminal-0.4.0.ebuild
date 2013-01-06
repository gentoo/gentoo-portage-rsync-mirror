# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/qterminal/qterminal-0.4.0.ebuild,v 1.2 2012/07/09 04:49:19 yngwin Exp $

EAPI="4"

inherit cmake-utils

DESCRIPTION="Qt4-based multitab terminal emulator"
HOMEPAGE="https://github.com/qterminal/"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qtermwidget"
RDEPEND="${DEPEND}"

#todo: translations
