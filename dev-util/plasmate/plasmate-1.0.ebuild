# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/plasmate/plasmate-1.0.ebuild,v 1.3 2014/02/09 19:07:57 kensington Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
inherit kde4-base

DESCRIPTION="IDE for writing KDE Plasma/KWin components (themes, Plasmoids, runners, data engines)"
HOMEPAGE="https://projects.kde.org/projects/extragear/sdk/plasmate"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	app-crypt/gpgme
	dev-libs/libattica
	dev-libs/soprano
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep knewstuff)
"

RDEPEND="
	${DEPEND}
	dev-vcs/git
"
