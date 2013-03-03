# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmiface/wmiface-2.1.ebuild,v 1.4 2013/03/02 23:54:30 hwoarang Exp $

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
	dev-qt/qtcore:4
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
