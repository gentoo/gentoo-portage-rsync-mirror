# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3check/mp3check-0.8.4.ebuild,v 1.5 2012/02/05 15:10:38 armin76 Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Checks mp3 files for consistency and prints several errors and warnings."
HOMEPAGE="http://jo.ath.cx/soft/mp3check/index.html"
SRC_URI="http://jo.ath.cx/soft/mp3check/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_prepare() {
	sed -i -e "/^WARN/s/-g//" Makefile || die
}

src_compile() {
	emake CXX="$(tc-getCXX)" OPT="${CXXFLAGS}"
}

src_install() {
	dobin mp3check
}
