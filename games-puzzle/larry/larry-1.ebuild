# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/larry/larry-1.ebuild,v 1.1 2013/07/13 22:07:07 hasufell Exp $

EAPI=5

inherit eutils check-reqs gnome2-utils games

DESCRIPTION="Leisure Suit Larry Reloaded"
HOMEPAGE="https://www.replaygamesinc.com"
SRC_URI="LarryReloadedLinux.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="splitdebug"

QA_PREBUILT="${GAMES_PREFIX_OPT#/}/${PN}/Larry-Linux
	${GAMES_PREFIX_OPT#/}/${PN}/Larry-Linux_Data/Mono/x86/libmono.so"
CHECKREQS_DISK_VAR="4500M"
CHECKREQS_DISK_USR="4500M"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

src_install() {
	newicon -s 128 Larry/Larry-Linux_Data/Resources/UnityPlayer.png ${PN}.png
	games_make_wrapper ${PN} "./Larry-Linux" "${GAMES_PREFIX_OPT}/${PN}"
	make_desktop_entry ${PN}

	# move it, over 4gb
	dodir "${GAMES_PREFIX_OPT}"/${PN}
	mv Larry/* "${ED%/}/${GAMES_PREFIX_OPT}"/${PN}/ || die

	fperms +x "${GAMES_PREFIX_OPT}"/${PN}/Larry-Linux

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
