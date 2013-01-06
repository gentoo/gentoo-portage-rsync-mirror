# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/abuse/abuse-0.7.1.ebuild,v 1.14 2011/08/07 14:27:37 armin76 Exp $

EAPI=2
inherit eutils games

ZOY="http://abuse.zoy.org/raw/Downloads"

DESCRIPTION="port of Abuse by Crack Dot Com"
HOMEPAGE="http://abuse.zoy.org/"
SRC_URI="${ZOY}/${P}.tar.gz
	!demo? ( ${ZOY}/abuse-data-2.00.tar.gz )
	demo? ( ${ZOY}/abuse-lib-2.00.tar.gz )
	sound? ( ${ZOY}/abuse-sfx-2.00.tar.gz )
	levels? ( ${ZOY}/abuse-frabs-2.11.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="demo levels sound"

RDEPEND=">=media-libs/libsdl-1.1.6[audio,opengl,video]
	virtual/opengl"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_prepare() {
	# fix placing additional patches
	use levels && cp -rf "${WORKDIR}"/abuse-frabs-2.11/{addon,art,levels,lisp,music,netlevel,register} "${WORKDIR}" && rm -rf "${WORKDIR}"/abuse-frabs-2.11/
	use demo && cp -rf "${WORKDIR}"/abuse-lib-2.00.orig/unpacked/{addon,art,levels,lisp,abuse.lsp} "${WORKDIR}" && rm -rf "${WORKDIR}"/abuse-lib-2.00.orig/
	use sound && cp -rf "${WORKDIR}"/abuse-sfx-2.00.orig/sfx "${WORKDIR}" && rm -rf "${WORKDIR}"/abuse-sfx-2.00.orig/
	# fix bug #231822
	sed -i \
		-e "s:/var/games/abuse:${GAMES_DATADIR}/${PN}:" \
		src/sdlport/setup.cpp || or die
	epatch "${FILESDIR}"/${P}-ovflfix.patch
}

src_configure() {
	# Abuse auto-appends games, so point to the base
	egamesconf --datadir="${GAMES_DATADIR_BASE}"
}

src_install() {
	# Source-based install
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO

	# Data install
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r "${WORKDIR}"/{addon,art,levels,lisp,music,netlevel,register,sfx} \
		"${WORKDIR}"/abuse.lsp \
		|| die

	doicon ${PN}.png
	make_desktop_entry abuse "Abuse"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "NOTE: If you had previous version of abuse installed"
	elog "you may need to remove ~/.abuse for the game to work correctly."
}
