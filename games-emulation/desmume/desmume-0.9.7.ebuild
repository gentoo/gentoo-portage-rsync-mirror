# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/desmume/desmume-0.9.7.ebuild,v 1.1 2011/11/12 21:01:35 hanno Exp $

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
	media-libs/libsdl[joystick]
	x11-libs/agg"
RDEPEND="${DEPEND}"

src_prepare() {
	# https://sourceforge.net/tracker/?func=detail&aid=3436660&group_id=164579&atid=832291
	epatch "${FILESDIR}/desmume-add-missing-potfiles.diff"
	# https://sourceforge.net/tracker/?func=detail&aid=3436995&group_id=164579&atid=832291
	epatch "${FILESDIR}/desmume-fix-gcc-warning.diff"
}

src_configure() {
	egamesconf --datadir=/usr/share || die "egamesconf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS ChangeLog README README.LIN
	prepgamesdirs
}
