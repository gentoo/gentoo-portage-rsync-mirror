# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ttcut/ttcut-0.19.6-r3.ebuild,v 1.6 2013/03/02 22:43:28 hwoarang Exp $

EAPI=4
inherit eutils fdo-mime qt4-r2

DESCRIPTION="Tool for cutting MPEG files especially for removing commercials"
HOMEPAGE="http://www.tritime.de/ttcut/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-libs/libmpeg2-0.4.0
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	virtual/glu
	virtual/opengl"
RDEPEND="${DEPEND}
	media-video/mplayer
	>=virtual/ffmpeg-0.6.90[encode]"

S=${WORKDIR}/${PN}

PATCHES=(
	"${FILESDIR}"/${P}-deprecated.patch
	"${FILESDIR}"/${P}-ntsc-fps.patch
	"${FILESDIR}"/${P}-ffmpeg-vf-setdar.patch
	"${FILESDIR}"/${P}-no_implicit_GLU.patch
	)

src_install() {
	dobin ttcut

	domenu "${FILESDIR}"/${PN}.desktop

	dodoc AUTHORS BUGS CHANGELOG README.* TODO
}
