# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wargus/wargus-2.2.5.5.ebuild,v 1.8 2012/06/01 20:24:32 hasufell Exp $

EAPI=2
inherit eutils cdrom games

DESCRIPTION="Warcraft II for the Stratagus game engine (Needs WC2 DOS CD)"
HOMEPAGE="http://wargus.sourceforge.net/"
SRC_URI="http://launchpad.net/wargus/trunk/${PV}/+download/wargus_${PV}.orig.tar.gz
	mirror://gentoo/wargus.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/libpng
	media-video/ffmpeg2theora"
RDEPEND="=games-engines/stratagus-${PV}*
	!games-strategy/wargus-data"

src_prepare() {
	cdrom_get_cds data/rezdat.war
	epatch "${FILESDIR}/${P}-libpng.patch"
	edos2unix build.sh
}

src_install() {
	local dir=${GAMES_DATADIR}/stratagus/${PN}

	dodir "${dir}"
	./build.sh -p "${CDROM_ROOT}" -o "${D}/${dir}" -v \
		|| die "Failed to extract data"
	games_make_wrapper wargus "./stratagus -d \"${dir}\"" "${GAMES_BINDIR}"
	prepgamesdirs

	doicon "${DISTDIR}"/wargus.png
	make_desktop_entry wargus Wargus
}
