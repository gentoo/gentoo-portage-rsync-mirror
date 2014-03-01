# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/cyphesis/cyphesis-0.6.0.ebuild,v 1.5 2014/03/01 22:26:58 mgorny Exp $

EAPI=5
PYTHON_DEPEND=2
inherit toolchain-funcs autotools python eutils games

DESCRIPTION="WorldForge server running small games"
HOMEPAGE="http://worldforge.org/dev/eng/servers/cyphesis"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=media-libs/skstream-0.3.9
	>=dev-games/wfmath-1.0.1
	>=dev-games/mercator-0.3.1
	dev-libs/libgcrypt:0
	dev-libs/libsigc++:2
	sys-libs/ncurses
	sys-libs/readline
	=media-libs/atlas-c++-0.6*
	>=media-libs/varconf-0.6.4
	dev-db/postgresql-base"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.40
	dev-libs/libxml2
	virtual/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-makefile.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--localstatedir=/var
}

src_compile() {
	emake AR="$(tc-getAR)"
}

src_install() {
	emake DESTDIR="${D}" confbackupdir="/usr/share/doc/${PF}/conf" \
		install
	dodoc AUTHORS ChangeLog FIXME NEWS README THANKS TODO
	prepgamesdirs
}
