# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-da2/ut2004-da2-1.6_beta.ebuild,v 1.6 2012/02/05 06:11:19 vapier Exp $

EAPI=2

MOD_DESC="assault mod with improved bot AI"
MOD_NAME="Defence Alliance 2"
MOD_DIR="DA2"
MOD_ICON="defencealliance2.xpm"

inherit eutils unpacker games games-mods

HOMEPAGE="http://www.planetunreal.com/da/2/"
SRC_URI="mirror://liflg/defence.alliance2_${PV/_}-english.run"

# See Help/readme.txt
LICENSE="free-noncomm"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

src_unpack() {
	unpack_makeself
	unpack ./da2.tar.gz
}

src_prepare() {
	mv -f *.xpm ${MOD_DIR} || die
	rm -rf bin setup.data
	rm -f *.gz README* *.sh
}
