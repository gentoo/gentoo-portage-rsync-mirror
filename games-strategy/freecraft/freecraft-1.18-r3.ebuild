# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecraft/freecraft-1.18-r3.ebuild,v 1.16 2011/09/14 20:10:50 mr_bones_ Exp $

EAPI=2
inherit eutils games

MY_P=${PN}-030311
DESCRIPTION="realtime strategy game engine for games like Warcraft/Starcraft/etc."
HOMEPAGE="http://www.math.sfu.ca/~cbm/cd/"
SRC_URI="${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
RESTRICT="fetch"

DEPEND="media-libs/libpng
	media-libs/libsdl[audio,video]
	|| ( sys-apps/util-linux[ddate] <sys-apps/util-linux-2.20 )"

S=${WORKDIR}/${MY_P}

pkg_nofetch() {
	einfo "Due to a Cease and Desist given by Blizzard,"
	einfo "you must obtain the sources for this game yourself."
	einfo "Use the power of the internet to do this."
	einfo "Also, you'll have to place the file ${A}"
	einfo "into ${DISTDIR}"
}

src_prepare() {
	sed -e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:GENTOO_LIBDIR:$(games_get_libdir)/${PN}:" \
		"${FILESDIR}"/${PN} > "${T}"/${PN} \
		|| die "sed failed"
	epatch \
		"${FILESDIR}"/${PV}-setup.patch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-Makefile.patch
	env GENTOO_CFLAGS="${CFLAGS}" ./setup || die
}

src_compile() {
	emake depend || die
	emake -j1 || die
}

src_install() {
	exeinto "$(games_get_libdir)"/${PN}
	doexe freecraft || die "doexe failed"
	dogamesbin "${T}"/${PN} || die "dogamesbin failed"

	exeinto "${GAMES_DATADIR}"/${PN}/tools
	doexe tools/{build.sh,aledoc,startool,wartool} || die "doexe failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r contrib data || die "doins failed"

	dohtml -r doc
	dodoc README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Freecraft is now installed but in order to actually play"
	elog "you will need to either use a Warcraft CD or install the"
	elog "freecraft-fcmp ebuild.  To use a Warcraft CD:"
	elog " 1 mount the cd as /mnt/cdrom"
	elog " 2 cd ${GAMES_DATADIR}/${PN}"
	elog " 3 run tools/build.sh"
	elog "This will extract the data files to the correct place."
	elog "Note that the CD is still needed for the music.  To"
	elog "start a game just run \"playfreecraft\"."
	elog "For more info, review \"freecraft --help\"."
}
