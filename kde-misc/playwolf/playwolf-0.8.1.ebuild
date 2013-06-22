# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/playwolf/playwolf-0.8.1.ebuild,v 1.1 2013/06/21 23:09:47 creffett Exp $

EAPI=5

KDE_MINIMAL="4.6"
inherit kde4-base

DESCRIPTION="KDE4 plasmoid. Controller and visualizer of information about the songs for amarok 2.0."
HOMEPAGE="http://www.kde-look.org/content/show.php/PlayWolf?content=93882"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop(+)')
	$(add_kdebase_dep plasma-workspace)
	media-sound/amarok
"

S="${WORKDIR}/${PN}"
