# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/brewtarget/brewtarget-1.2.4.ebuild,v 1.1 2012/03/14 00:16:53 pesa Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Application to create and manage beer recipes"
HOMEPAGE="http://brewtarget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3 WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="kde"

DEPEND="
	>=x11-libs/qt-core-4.6:4
	>=x11-libs/qt-gui-4.6:4
	>=x11-libs/qt-svg-4.6:4
	>=x11-libs/qt-webkit-4.6:4
	kde? ( media-libs/phonon )
	!kde? ( || ( >=x11-libs/qt-phonon-4.6:4 media-libs/phonon ) )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PV}-find-phonon.patch"
)

src_prepare() {
	base_src_prepare

	# Fix docs install path
	sed -i -e "/DOCDIR / s:\${CMAKE_PROJECT_NAME}:${PF}:" \
		CMakeLists.txt || die

	# Append missing semicolon to Categories in desktop file
	sed -i -e '/^Categories=/ s:$:;:' ${PN}.desktop.in || die
}
