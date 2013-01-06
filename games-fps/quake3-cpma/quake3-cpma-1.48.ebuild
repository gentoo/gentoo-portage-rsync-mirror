# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-cpma/quake3-cpma-1.48.ebuild,v 1.4 2012/02/01 16:38:22 mr_bones_ Exp $

EAPI=2

MOD_DESC="advanced FPS competition mod"
MOD_NAME="Challenge Pro Mode Arena"
MOD_DIR="cpma"

inherit games games-mods

HOMEPAGE="http://www.promode.org/"
SRC_URI="http://www.slashquit.net/files/x/q3/cpma${PV//.}-nomaps.zip
	http://www.slashquit.net/files/x/q3/cpma-mappack-full.zip"

LICENSE="as-is"
KEYWORDS="~ppc x86"
IUSE="dedicated opengl"

src_prepare() {
	mv -f *.pk3 ${MOD_DIR} || die
}

pkg_postinst() {
	games-mods_pkg_postinst
	elog "To enable bots: +bot_enable 1"
}
