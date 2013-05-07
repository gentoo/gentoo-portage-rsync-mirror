# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcometen4/kcometen4-1.0.7.ebuild,v 1.5 2013/05/07 20:50:43 johu Exp $

EAPI=5

OPENGL_REQUIRED="always"
KDE_MINIMAL="4.10.3"
inherit kde4-base

HOMEPAGE="http://www.kde-apps.org/content/show.php?content=87586"
DESCRIPTION="OpenGL KDE4 screensaver"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/87586-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	${DEPEND}
	$(add_kdebase_dep kscreensaver)
	media-libs/libart_lgpl
	virtual/opengl
"
RDEPEND="${DEPEND}"
