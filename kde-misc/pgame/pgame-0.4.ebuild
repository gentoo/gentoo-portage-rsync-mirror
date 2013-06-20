# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/pgame/pgame-0.4.ebuild,v 1.1 2013/06/19 23:14:30 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="A plasmoid similar to xgame"
HOMEPAGE="http://kde-look.org/content/show.php/PGame?content=99357"
SRC_URI="http://kde-look.org/CONTENT/content-files/99357-pgame-${PV}.tar.bz2"

LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
"
DEPEND="${RDEPEND}"
