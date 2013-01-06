# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3diags/mp3diags-1.0.11.076.ebuild,v 1.1 2012/07/09 18:19:18 kensington Exp $

EAPI=4

inherit eutils qt4-r2

MY_PN=${PN/mp3d/MP3D}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Qt-based MP3 diagnosis and repair tool"
HOMEPAGE="http://mp3diags.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/boost-1.37
	sys-libs/zlib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	x11-libs/qt-svg:4"

S=${WORKDIR}/${MY_P}

src_install() {
	dobin bin/${MY_PN}
	dodoc changelog.txt

	local size
	for size in 16 22 24 32 36 40 48; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		newins desktop/${MY_PN}${size}.png ${MY_PN}.png
	done
	domenu desktop/${MY_PN}.desktop || die
}
