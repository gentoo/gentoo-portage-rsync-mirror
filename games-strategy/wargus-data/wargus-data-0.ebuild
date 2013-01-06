# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wargus-data/wargus-data-0.ebuild,v 1.3 2012/06/06 19:27:37 hasufell Exp $

EAPI=4

inherit cdrom games

DESCRIPTION="Warcraft II data for wargus (needs DOS CD)"
HOMEPAGE="http://wargus.sourceforge.net/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=games-strategy/wargus-2.2.6"
DEPEND="${RDEPEND}
	media-sound/cdparanoia
	media-sound/timidity++
	media-video/ffmpeg2theora"
# wrt bug #419331
RESTRICT="userpriv"

S=${WORKDIR}

src_prepare() {
	export CDROM_NAME="WARCRAFT2"
	cdrom_get_cds data/rezdat.war
}

src_compile() {
	# cdparanoia needs write acces to the cdrom device
	# this fixes sandbox violation wrt #418051
	local save_sandbox_write=${SANDBOX_WRITE}
	addwrite /dev
	"${GAMES_BINDIR}"/wartool -m -v -r "${CDROM_ROOT}"/data "${S}"/ || die
	SANDBOX_WRITE=${save_sandbox_write}
}

src_install() {
	insinto "${GAMES_DATADIR}"/stratagus/wargus
	doins -r *
	prepgamesdirs
}
