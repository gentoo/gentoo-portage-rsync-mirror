# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasma-lionmail/plasma-lionmail-0_p20121020.ebuild,v 1.1 2012/10/21 01:29:45 creffett Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="A Plasma widget displaying new and important email"
HOMEPAGE="http://www.kde.org http://www.vizzzion.org"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdelibs)
	$(add_kdebase_dep kdepimlibs)
	app-office/akonadi-server
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-runtime)
"
