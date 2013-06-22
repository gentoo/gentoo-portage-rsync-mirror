# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/eyesaver/eyesaver-0.4.ebuild,v 1.1 2013/06/22 21:56:01 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE4 plasmoid. Reminds us to take our eyes off the screen"
HOMEPAGE="http://www.kde-look.org/content/show.php/Eyesaver?content=89989"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/89989-${P}.tar.gz"

LICENSE="GPL-1"
# License unclear, HOMEPAGE and .desktop file have "GPL", assuming GPL-1.
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="media-libs/phonon"
RDEPEND="
	${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

PATCHES=( "${FILESDIR}/eyesaver-0.2a-fix.patch" )
