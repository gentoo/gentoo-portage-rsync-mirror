# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/liquidwar/liquidwar-5.6.4.ebuild,v 1.11 2012/03/22 01:20:56 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="unique multiplayer wargame"
HOMEPAGE="http://www.ufoot.org/liquidwar/"
SRC_URI="http://savannah.nongnu.org/download/liquidwar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="nls"
RESTRICT="test"

DEPEND=">=media-libs/allegro-4.2:0[X]"

src_prepare() {
	epatch "${FILESDIR}"/${P}-exec-stack.patch \
		"${FILESDIR}"/${P}-ovflfix.patch
	sed -i \
		-e 's:/games::' \
		-e '/^MANDIR/ s:=.*:= $(mandir)/man6:' \
		-e '/^PIXDIR/ s:=.*:= /usr/share/pixmaps:' \
		-e '/^DESKTOPDIR/ s:=.*:= /usr/share/applnk/Games/:' \
		-e '/^INFODIR/ s/=.*/= $(infodir)/' \
		-e '/^GAMEDIR/ s/exec_prefix/bindir/' \
		-e '/install/s:-s ::' \
		-e 's:$(DOCDIR)/txt:$(DOCDIR):g' \
		-e 's:$(GMAKE):$(MAKE):' \
		-e '/^DOCDIR/ s:=.*:= /usr/share/doc/$(PF):' Makefile.in \
		|| die 'sed Makefile.in failed'
	sed -i \
		-e '/^GAMEDIR/ s/$(exec_prefix)/@bindir@/' \
		-e 's:/games::' src/Makefile.in \
		|| die "sed src/Makefile.in failed"
	epatch "${FILESDIR}"/${P}-underlink.patch
}

src_configure() {
	egamesconf \
		--disable-doc-ps \
		--disable-doc-pdf \
		--disable-target-opt \
		$(use_enable x86 asm)
}

src_install() {
	emake DESTDIR="${D}" install_nolink || die "emake install failed"
	rm -f "${D}"/usr/share/doc/${PF}/COPYING
	use nls || rm -f "${D}"/usr/share/doc/${PF}/README.*
	prepalldocs
	prepgamesdirs
}
