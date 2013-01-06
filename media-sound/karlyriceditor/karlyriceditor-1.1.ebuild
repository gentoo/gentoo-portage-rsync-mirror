# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/karlyriceditor/karlyriceditor-1.1.ebuild,v 1.1 2012/01/22 21:35:15 ssuominen Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="A program which lets you edit and synchronize lyrics with karaoke songs in varions formats"
HOMEPAGE="http://www.karlyriceditor.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/phonon
	x11-libs/qt-core:4
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

src_install() {
	dobin bin/${PN}
	doicon packages/${PN}.png
	make_desktop_entry ${PN} 'Karaoke Lyrics Editor'
}
