# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkgeomap/libkgeomap-3.5.0.ebuild,v 1.4 2014/03/14 13:20:52 kensington Exp $

EAPI=5

KDE_MINIMAL="4.10"
VIRTUALX_REQUIRED="test"
inherit kde4-base

MY_PV=${PV/_/-}
MY_P="digikam-${MY_PV}"
SRC_URI="mirror://kde/stable/digikam/${MY_P}.tar.bz2"

DESCRIPTION="Wrapper library for world map components as marble, openstreetmap and googlemap"
HOMEPAGE="http://www.digikam.org/"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""
SLOT=4

DEPEND="
	$(add_kdebase_dep libkexiv2)
	$(add_kdebase_dep marble kde,plasma)
"
RDEPEND=${DEPEND}

S="${WORKDIR}/${MY_P}/extra/${PN}"
