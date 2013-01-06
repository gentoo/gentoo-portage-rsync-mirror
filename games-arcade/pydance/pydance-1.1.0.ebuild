# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pydance/pydance-1.1.0.ebuild,v 1.4 2011/06/24 18:51:25 ranger Exp $

EAPI=2
inherit eutils games

DESCRIPTION="a DDR clone for linux written in Python"
HOMEPAGE="http://www.icculus.org/pyddr/"
SRC_URI="http://www.icculus.org/pyddr/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-python/pygame
	media-libs/libvorbis
	media-libs/sdl-mixer"
PDEPEND="games-arcade/pydance-songs"

src_prepare() {
	sed -i \
		-e "s:1\.0\.1:1.0.2:" \
		-e "s:/etc/:${GAMES_SYSCONFDIR}/:" \
		pydance.py constants.py docs/man/pydance.6 \
		|| die "sed failed"
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}

	insinto "${dir}"
	doins *.py || die "doins failed"
	cp -R CREDITS {sound,images,utils,themes} "${D}${dir}/" || die "cp failed"

	insinto "${GAMES_SYSCONFDIR}"
	newins pydance.posix.cfg pydance.cfg

	games_make_wrapper pydance "python ./pydance.py" "${dir}"

	dodoc BUGS CREDITS ChangeLog HACKING README TODO
	dohtml -r docs/manual.html docs/images
	doman docs/man/*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "If you want to use a DDR pad with pyDance,"
	elog "all you need to do is emerge the games-arcade/ddrmat kernel module."
	echo
}
