# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cwtext/cwtext-0.94.ebuild,v 1.18 2012/02/05 15:46:26 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Text to Morse Code converter"
HOMEPAGE="http://cwtext.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ~ppc64 x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# change install directory to ${S}
	sed -i -e "/^PREFIX/ s:=.*:=\"${S}\":" makefile || \
		die "sed makefile failed"

	epatch "${FILESDIR}"/${P}-asneeded.patch
	tc-export CC
}

src_install() {
	dobin cwtext cwpcm cwmm || die "dobin failed"

	dodoc Changes README TODO
}
