# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/bespin/bespin-0_p20120929.ebuild,v 1.4 2013/10/01 21:45:36 pesa Exp $

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
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	windeco? ( $(add_kdebase_dep kwin) )
	plasma? ( $(add_kdebase_dep kdelibs) dev-qt/qtdbus:4 )
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable kde KDE)
		$(cmake-utils_use_enable windeco KWIN)
		$(cmake-utils_use_enable windeco 474_SHADOWS)
		$(cmake-utils_use_enable plasma XBAR)
		-DENABLE_ARGB=ON
	)

	kde4-base_src_configure
}
