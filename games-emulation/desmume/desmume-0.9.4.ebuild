# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/desmume/desmume-0.9.4.ebuild,v 1.4 2011/03/01 07:31:40 mr_bones_ Exp $

EAPI="2"

inherit eutils games

DESCRIPTION="Nintendo DS emulator"
HOMEPAGE="http://desmume.org/"
SRC_URI="mirror://sourceforge/desmume/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.8.0:2
	gnome-base/libglade
	x11-libs/gtkglext
	virtual/opengl
	sys-libs/zlib
	dev-libs/zziplib
	media-libs/libsdl[joystick]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc44.patch"
}

src_configure() {
	egamesconf --datadir=/usr/share || die "egamesconf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS ChangeLog README README.LIN
	prepgamesdirs
}
