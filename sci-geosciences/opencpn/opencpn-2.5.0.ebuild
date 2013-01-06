# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/opencpn/opencpn-2.5.0.ebuild,v 1.4 2011/11/19 09:48:59 hwoarang Exp $

EAPI=4

WX_GTK_VER="2.8"
MY_P=OpenCPN-${PV}-Source
inherit cmake-utils wxwidgets

DESCRIPTION="a free, open source software for marine navigation"
HOMEPAGE="http://opencpn.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gpsd"

RDEPEND="
	app-arch/bzip2
	dev-libs/tinyxml
	media-libs/freetype:2
	sys-libs/zlib
	virtual/opengl
	x11-libs/gtk+:2
	>=x11-libs/wxGTK-2.8.8[X]
	gpsd? ( >=sci-geosciences/gpsd-2.90 )
"
DEPEND="${DEPEND}
	sys-devel/gettext"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/${P}-multilib-strict.patch"
	"${FILESDIR}/${P}_tinyxml_stl.patch"
)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use gpsd GPSD)
		-DUSE_S57=ON
		-DUSE_GARMINHOST=ON
		-DUSE_WIFI_CLIENT=OFF
	)

	cmake-utils_src_configure
}
