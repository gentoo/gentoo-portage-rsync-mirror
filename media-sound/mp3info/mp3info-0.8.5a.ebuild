# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3info/mp3info-0.8.5a.ebuild,v 1.10 2011/03/12 09:59:28 radhermit Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="An MP3 technical info viewer and ID3 1.x tag editor"
HOMEPAGE="http://ibiblio.org/mp3info/"
SRC_URI="http://ibiblio.org/pub/linux/apps/sound/mp3-utils/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="gtk"

DEPEND="gtk? ( >=x11-libs/gtk+-2.6.10:2 )
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_compile() {
	emake mp3info CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
	if use gtk; then
		emake gmp3info CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "gtk mp3info failed"
	fi
}

src_install() {
	dobin mp3info
	use gtk && dobin gmp3info

	dodoc ChangeLog README
	doman mp3info.1
}
