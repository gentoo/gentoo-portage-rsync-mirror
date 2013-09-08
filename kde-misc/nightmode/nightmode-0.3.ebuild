# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/nightmode/nightmode-0.3.ebuild,v 1.4 2013/09/08 13:45:42 kensington Exp $

EAPI=4

KDE_MINIMAL="4.8"
inherit kde4-base

DESCRIPTION="kwin plugin that makes the entire screen darker"
HOMEPAGE="http://kde-apps.org/content/show.php/Nightmode?content=123805"
SRC_URI="http://static.davidedmundson.co.uk/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="$(add_kdebase_dep kwin)"
RDEPEND="${DEPEND}"

S=${WORKDIR}

PATCHES=( "${FILESDIR}/${P}-kde-4.10.patch" )
