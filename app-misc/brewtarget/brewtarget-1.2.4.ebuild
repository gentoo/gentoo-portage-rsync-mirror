# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/brewtarget/brewtarget-1.2.4.ebuild,v 1.3 2013/07/18 21:57:13 creffett Exp $

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
	>=dev-qt/qtcore-4.6:4
	>=dev-qt/qtgui-4.6:4
	>=dev-qt/qtsvg-4.6:4
	>=dev-qt/qtwebkit-4.6:4
	kde? ( media-libs/phonon )
	!kde? ( || ( >=dev-qt/qtphonon-4.6:4 media-libs/phonon ) )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PV}-find-phonon.patch"
)

src_prepare() {
	cmake-utils_src_prepare

	# Fix docs install path
	sed -i -e "/DOCDIR / s:\${CMAKE_PROJECT_NAME}:${PF}:" \
		CMakeLists.txt || die

	# Append missing semicolon to Categories in desktop file
	sed -i -e '/^Categories=/ s:$:;:' ${PN}.desktop.in || die
}
