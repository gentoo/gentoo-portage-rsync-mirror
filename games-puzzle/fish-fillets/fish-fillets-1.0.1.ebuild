# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fish-fillets/fish-fillets-1.0.1.ebuild,v 1.5 2012/05/04 04:45:27 jdhore Exp $

EAPI=2
inherit autotools eutils games

DATA_PV="1.0.0"
DESCRIPTION="Underwater puzzle game - find a safe way out"
HOMEPAGE="http://fillets.sourceforge.net/"
SRC_URI="mirror://sourceforge/fillets/fillets-ng-${PV}.tar.gz
	mirror://sourceforge/fillets/fillets-ng-data-${DATA_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2[audio,video]
	>=media-libs/sdl-mixer-1.2.5[vorbis]
	>=media-libs/sdl-image-1.2.2[png]
	media-libs/smpeg
	x11-libs/libX11
	media-libs/sdl-ttf
	dev-libs/fribidi
	>=dev-lang/lua-5"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/fillets-ng-${PV}

src_prepare() {
	#.mod was renamed to .fmod in lua 5.1.3 - bug #223271
	sed -i \
		-e 's/\.mod(/.fmod(/' \
		$(grep -rl "\.mod\>" "${WORKDIR}"/fillets-ng-data-${DATA_PV}) \
		|| die "sed failed"
	rm -f missing
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR}/${PN}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	insinto "${GAMES_DATADIR}/${PN}"
	cd "${WORKDIR}"/fillets-ng-data-${DATA_PV} || die
	rm -f COPYING
	doins -r * || die "doins failed"
	newicon images/icon.png ${PN}.png
	make_desktop_entry fillets "Fish Fillets NG"
	prepgamesdirs
}
