# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/cyphesis/cyphesis-0.5.26.ebuild,v 1.5 2012/08/04 10:51:53 ago Exp $

EAPI=2
PYTHON_DEPEND=2
inherit autotools python eutils games

DESCRIPTION="WorldForge server running small games"
HOMEPAGE="http://worldforge.org/dev/eng/servers/cyphesis"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=media-libs/skstream-0.3.8
	>=dev-games/wfmath-0.3.11
	>=dev-games/mercator-0.3.0
	dev-libs/libgcrypt
	dev-libs/libsigc++:2
	sys-libs/ncurses
	sys-libs/readline
	=media-libs/atlas-c++-0.6*
	>=media-libs/varconf-0.6.4
	dev-db/postgresql-base"
DEPEND="${RDEPEND}
	dev-libs/libxml2
	virtual/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--localstatedir=/var
}

src_install() {
	emake DESTDIR="${D}" confbackupdir="/usr/share/doc/${PF}/conf" \
		install || die "emake install failed"
	dodoc AUTHORS ChangeLog FIXME NEWS README THANKS TODO
	prepgamesdirs
}
