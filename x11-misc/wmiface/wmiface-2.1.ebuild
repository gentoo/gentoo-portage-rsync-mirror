# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmiface/wmiface-2.1.ebuild,v 1.3 2012/07/14 17:46:30 kensington Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Command line tool allowing user scripting of the running window manager"
HOMEPAGE="http://kde-apps.org/content/show.php/WMIface?content=40425"
SRC_URI="http://home.kde.org/~seli/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	x11-libs/qt-core:4
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
