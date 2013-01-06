# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tetrinet/tetrinet-0.11.ebuild,v 1.14 2010/07/14 17:38:21 mr_bones_ Exp $

EAPI=2
inherit eutils flag-o-matic games

DESCRIPTION="console based tetrinet inc. standalone server"
HOMEPAGE="http://tetrinet.or.cz/"
SRC_URI="http://tetrinet.or.cz/download/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-no-ipv6.patch \
		"${FILESDIR}"/${P}-build.patch

	use ipv6 && append-flags -DHAVE_IPV6
}

src_install() {
	dogamesbin tetrinet tetrinet-server || die "dogamesbin failed"
	dodoc README TODO tetrinet.txt
	prepgamesdirs
}
