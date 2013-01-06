# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapnik-world-boundaries/mapnik-world-boundaries-20090514.ebuild,v 1.1 2009/06/23 15:46:51 tupone Exp $
EAPI=2

DESCRIPTION="Mapnik World Boundaries"
HOMEPAGE="http://www.openstreetmap.org/"
SRC_URI="mirror://gentoo/world_boundaries-spherical-20090331.tgz
	mirror://gentoo/processed_p-20090514.zip"

LICENSE="CCPL-Attribution-ShareAlike-2.0"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

src_prepare() {
	mv coastlines/* world_boundaries/
}

src_install() {
	insinto /usr/share/mapnik
	doins -r world_boundaries
}
