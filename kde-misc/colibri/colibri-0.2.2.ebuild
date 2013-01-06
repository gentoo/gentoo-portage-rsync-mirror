# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/colibri/colibri-0.2.2.ebuild,v 1.4 2012/07/24 21:19:19 hwoarang Exp $

EAPI=4

KDE_LINGUAS="cs de es it pt_BR sk tr"
inherit kde4-base

DESCRIPTION="Alternative to KDE4 Plasma notifications"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=117147"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/117147-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="
	x11-libs/libX11
	x11-libs/libXext"
RDEPEND=${DEPEND}
