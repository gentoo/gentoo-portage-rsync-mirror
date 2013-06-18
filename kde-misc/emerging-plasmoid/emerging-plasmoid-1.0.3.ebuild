# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/emerging-plasmoid/emerging-plasmoid-1.0.3.ebuild,v 1.1 2013/06/17 23:09:52 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Portage emerge progress plasmoid"
HOMEPAGE="http://kde-apps.org/content/show.php/Emerging+Plasmoid?content=147414 "
SRC_URI="mirror://github/leonardo2d/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"
