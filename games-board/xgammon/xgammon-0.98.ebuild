# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xgammon/xgammon-0.98.ebuild,v 1.15 2012/09/10 08:36:11 tupone Exp $

EAPI=2
inherit toolchain-funcs eutils

DESCRIPTION="very nice backgammon game for X"
HOMEPAGE="http://fawn.unibw-hamburg.de/steuer/xgammon/xgammon.html"
SRC_URI="http://fawn.unibw-hamburg.de/steuer/xgammon/Downloads/${P}a.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libXaw"
DEPEND="${RDEPEND}
	app-text/rman
	x11-misc/imake"

S=${WORKDIR}/${P}a

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-broken.patch" \
		"${FILESDIR}/${P}-config.patch" \
		"${FILESDIR}/gcc33.patch"
}

src_configure() {
	xmkmf || die "xmkmf died"
}

src_compile() {
	env PATH=".:${PATH}" emake \
		EXTRA_LDOPTIONS="${LDFLAGS}" \
		CDEBUGFLAGS="${CFLAGS}" \
		CC=$(tc-getCC) \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	games_pkg_postinst
	einfo "xgammon need helvetica fonts"
	einfo "They can be loaded emerging media-fonts/font-adobe-100dpi"
	einfo "or similar. Remember to restart X after loading fonts"
}
