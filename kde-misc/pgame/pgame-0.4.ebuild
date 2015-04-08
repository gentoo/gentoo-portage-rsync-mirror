# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/pgame/pgame-0.4.ebuild,v 1.2 2014/07/25 21:35:46 johu Exp $

EAPI=5

KDE_MINIMAL="4.13.1"
inherit kde4-base

DESCRIPTION="A plasmoid similar to xgame"
HOMEPAGE="http://kde-look.org/content/show.php/PGame?content=99357"
SRC_URI="http://kde-look.org/CONTENT/content-files/99357-pgame-${PV}.tar.bz2"

LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdelibs 'nepomuk')
	$(add_kdebase_dep plasma-workspace '' 4.11)
	$(add_kdebase_dep nepomuk)
"
DEPEND="${RDEPEND}"
