# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xblast/xblast-2.10.4.ebuild,v 1.5 2009/04/15 22:00:30 nyhm Exp $

EAPI=2
inherit autotools games

# Change these as releases changes
IMAGES="images-2005-01-06"
LEVELS="levels-2005-01-06"
MODELS="models-2005-01-06"
MUSICS="musics-2005-01-06"
SOUNDS="sounds"

DESCRIPTION="Bomberman clone w/network support for up to 6 players"
HOMEPAGE="http://xblast.sourceforge.net/"
SRC_URI="mirror://sourceforge/xblast/${P}.tar.gz
	mirror://sourceforge/xblast/${IMAGES}.tar.gz
	mirror://sourceforge/xblast/${LEVELS}.tar.gz
	mirror://sourceforge/xblast/${MODELS}.tar.gz
	mirror://sourceforge/xblast/${MUSICS}.tar.gz
	mirror://sourceforge/xblast/${SOUNDS}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libICE
	x11-libs/libX11
	media-libs/libpng"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_prepare() {
	eautoreconf #255857
}

src_configure() {
	egamesconf \
		--with-otherdatadir="${GAMES_DATADIR}"/${PN} \
		--enable-sound \
		|| die
}

src_install() {
	local IMAGE_INSTALL_DIR="${GAMES_DATADIR}/${PN}/image"

	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README

	# Images
	dodir "${IMAGE_INSTALL_DIR}"
	cp -pPR "${WORKDIR}/${IMAGES}"/* "${D}/${IMAGE_INSTALL_DIR}" \
		|| die "cp failed"

	# Levels
	insinto "${GAMES_DATADIR}/xblast/level"
	doins "${WORKDIR}/${LEVELS}"/* || die "doins failed"

	# Models
	insinto "${GAMES_DATADIR}/xblast/image/sprite"
	doins "${WORKDIR}/${MODELS}"/* || die "doins failed"

	# Music and sound
	insinto "${GAMES_DATADIR}/xblast/sounds"
	doins "${WORKDIR}/${MUSICS}"/* "${WORKDIR}/${SOUNDS}"/* \
		|| die "doins failed"

	# Cleanup
	find "${D}" -name Imakefile -exec rm \{\} \;

	prepgamesdirs
}
