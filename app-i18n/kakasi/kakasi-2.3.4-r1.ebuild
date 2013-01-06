# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kakasi/kakasi-2.3.4-r1.ebuild,v 1.5 2011/12/18 20:12:27 phajdan.jr Exp $

inherit toolchain-funcs

DESCRIPTION="Converts Japanese text between kanji, kana, and romaji"
HOMEPAGE="http://kakasi.namazu.org/"
SRC_URI="http://kakasi.namazu.org/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

src_compile() {
	econf || die
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	doman doc/kakasi.1 || die
	dodoc AUTHORS ChangeLog NEWS ONEWS README README-ja THANKS TODO || die
	dodoc doc/ChangeLog.lib doc/JISYO doc/README.lib || die
}
