# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kvkbd/kvkbd-0.6-r1.ebuild,v 1.1 2014/03/21 18:41:56 johu Exp $

EAPI=5

inherit kde4-base

KDEAPPS_ID="94374"

DESCRIPTION="A virtual keyboard for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=94374"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${KDEAPPS_ID}-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

PATCHES=(
	"${FILESDIR}/${P}-underlinking.patch"
)
