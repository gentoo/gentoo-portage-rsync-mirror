# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xpilot/xpilot-4.5.5.ebuild,v 1.3 2010/06/21 20:13:52 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A multi-player 2D client/server space game"
HOMEPAGE="http://www.xpilot.org/"
SRC_URI="mirror://sourceforge/xpilotgame/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	x11-misc/gccmakedep
	x11-misc/imake
	app-text/rman"

src_prepare() {
	sed -i \
		-e '/^INSTMAN/s:=.*:=/usr/share/man/man6:' \
		-e "/^INSTLIB/s:=.*:=${GAMES_DATADIR}/${PN}:" \
		-e "/^INSTBIN/s:=.*:=${GAMES_BINDIR}:" \
		Local.config \
		|| die "sed failed"
}

src_compile() {
	xmkmf || die "xmkmf failed"
	emake Makefiles || die "emake Makefiles failed"
	emake includes || die "emake includes failed"
	emake depend || die "emake depend failed"
	emake CC="${CC}" CDEBUGFLAGS="${CFLAGS} ${LDFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	emake DESTDIR="${D}" install.man || die "emake install.man failed"
	newicon lib/textures/logo.ppm ${PN}.ppm
	make_desktop_entry ${PN} XPilot /usr/share/pixmaps/${PN}.ppm
	dodoc README.txt doc/{ChangeLog,CREDITS,FAQ,README*,TODO}
	prepgamesdirs
}
