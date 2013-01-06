# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/trebuchet/trebuchet-1.052.ebuild,v 1.9 2011/12/09 19:04:45 mr_bones_ Exp $

EAPI=2
inherit games

MY_P="TrebTk${PV/./}"
DESCRIPTION="A crossplatform TCL/TK based MUD client"
HOMEPAGE="http://belfry.com/fuzzball/trebuchet/"
SRC_URI="mirror://sourceforge/trebuchet/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=dev-lang/tk-8.3.3
	dev-lang/tcl"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e "/Nothing/d" \
		-e "/LN/ s:../libexec:${GAMES_DATADIR}:" \
		Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	make prefix="${D}${GAMES_PREFIX}" \
		ROOT="${D}${GAMES_DATADIR}/${PN}" \
			install || die "make install failed"
	# gui uses the COPYING file
	cp COPYING "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc changes.txt ideas.txt proxysam.txt readme.txt trebtodo.txt
	prepgamesdirs
}
