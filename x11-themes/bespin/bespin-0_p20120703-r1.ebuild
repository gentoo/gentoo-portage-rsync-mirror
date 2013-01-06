# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/bespin/bespin-0_p20120703-r1.ebuild,v 1.2 2012/07/14 17:41:41 kensington Exp $

EAPI=4
KDE_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Very configurable Qt4/KDE4 style derived from the Oxygen project."
HOMEPAGE="http://cloudcity.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug kde plasma windeco"

REQUIRED_USE="
		windeco? ( kde )
		plasma? ( kde )
"

DEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	windeco? ( $(add_kdebase_dep kwin) )
	plasma? ( $(add_kdebase_dep kdelibs) x11-libs/qt-gui:4[dbus] )
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable kde KDE)
		$(cmake-utils_use_enable windeco KWIN)
		$(cmake-utils_use_enable plasma XBAR)
		-DENABLE_ARGB=ON
	)

	kde4-base_src_configure
}
