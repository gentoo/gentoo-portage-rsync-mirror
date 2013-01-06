# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3v2/id3v2-0.1.11.ebuild,v 1.11 2011/12/18 18:17:49 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A command line editor for id3v2 tags."
HOMEPAGE="http://id3v2.sourceforge.net/"
SRC_URI="mirror://sourceforge/id3v2/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/id3lib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-alpha.patch"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" LDFLAGS="${LDFLAGS}" \
		OPT_CXXFLAGS="${CXXFLAGS}" || die "emake failed."
}

src_install() {
	dobin id3v2
	doman id3v2.1
	dodoc README
}
