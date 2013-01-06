# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/structure-synth/structure-synth-1.5.0.ebuild,v 1.1 2011/05/28 09:21:33 radhermit Exp $

EAPI=4

inherit eutils qt4-r2

MY_P="StructureSynth-Source-v${PV}"
DESCRIPTION="A program to generate 3D structures by specifying a design grammar"
HOMEPAGE="http://structuresynth.sourceforge.net/"
SRC_URI="mirror://sourceforge/structuresynth/${MY_P}.zip"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-script:4"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/Structure Synth Source Code"

src_prepare() {
	qmake -project -o ${PN}.pro -after "CONFIG+=opengl" \
		-after "QT+=xml opengl script" || die "qmake failed"
}

src_install() {
	dobin ${PN}
	dodoc roadmap.txt changelog.txt bugs.txt
	domenu ${PN}.desktop
	newicon images/structuresynth.png ${PN}.png
}
