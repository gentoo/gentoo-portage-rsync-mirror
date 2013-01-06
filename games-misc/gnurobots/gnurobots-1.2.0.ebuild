# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/gnurobots/gnurobots-1.2.0.ebuild,v 1.11 2012/12/15 18:47:21 dolsen Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="construct a program for a little robot then set him loose
and watch him explore a world on his own"
HOMEPAGE="http://www.gnu.org/software/gnurobots/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""
RESTRICT="test"

DEPEND="x11-libs/vte:0
	dev-scheme/guile[deprecated]"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
	sed -i \
		-e 's/-pedantic-errors -Werror//' \
		configure.ac \
		|| die "sed failed"
	eautoreconf
}

src_install() {
	dodoc AUTHORS \
		ChangeLog \
		NEWS \
		README \
		THANKS \
		TODO \
		doc/Robots-HOWTO \
		doc/contrib
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
