# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kinfocenter/kinfocenter-4.9.4.ebuild,v 1.1 2012/12/05 16:57:44 alexxy Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The KDE Info Center"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug ieee1394"

DEPEND="
	$(add_kdebase_dep solid)
	sys-apps/pciutils
	ieee1394? ( sys-libs/libraw1394 )
	opengl? (
		virtual/glu
		virtual/opengl
	)
"
RDEPEND="${DEPEND}
	sys-apps/usbutils
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with ieee1394 RAW1394)
		$(cmake-utils_use_with opengl OpenGL)
	)

	kde4-meta_src_configure
}
