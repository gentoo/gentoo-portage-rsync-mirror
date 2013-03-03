# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quimup/quimup-1.2.0.ebuild,v 1.9 2013/03/02 22:02:51 hwoarang Exp $

EAPI=3
inherit eutils qt4-r2

MY_P=${PN}_${PV}

DESCRIPTION="A Qt4 client for the music player daemon (MPD) written in C++"
HOMEPAGE="http://mpd.wikia.com/wiki/Client:Quimup"
SRC_URI="mirror://sourceforge/musicpd/${MY_P}_source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-qt/qtgui:4
	>=media-libs/libmpdclient-2.2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e "/FLAGS/d" ${PN}.pro || die
	epatch "${FILESDIR}"/${P}-gcc47.patch
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc changelog FAQ.txt README || die "dodoc failed"

	newicon Icons/${PN}64.png ${PN}.png || die "newins failed"

	make_desktop_entry ${PN} Quimup
}
