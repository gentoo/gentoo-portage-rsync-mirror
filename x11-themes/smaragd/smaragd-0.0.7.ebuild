# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smaragd/smaragd-0.0.7.ebuild,v 1.2 2011/08/31 21:03:59 dilfridge Exp $

EAPI=4

KDE_MINIMAL="4.6"
inherit kde4-base

DESCRIPTION="KWin theme engine that uses Emerald themes"
HOMEPAGE="http://kde-look.org/content/show.php?content=125162"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/125162-${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkworkspace)
	x11-libs/cairo
"
RDEPEND="
	${DEPEND}
	$(add_kdebase_dep kwin)
"
