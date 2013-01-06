# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crystal/crystal-2.2.0.ebuild,v 1.3 2012/11/23 19:38:16 ago Exp $

EAPI=4
KDE_MINIMAL="4.9"
inherit kde4-base

DESCRIPTION="Crystal decoration theme for KDE4.x"
HOMEPAGE="http://kde-look.org/content/show.php/Crystal?content=75140"
SRC_URI="http://www.saschahlusiak.de/linux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="$(add_kdebase_dep kwin)"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS README )
