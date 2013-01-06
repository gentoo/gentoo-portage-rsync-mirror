# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geekcode/geekcode-1.7.3-r1.ebuild,v 1.7 2012/03/18 18:52:52 armin76 Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Geek code generator"
HOMEPAGE="http://geekcode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~mips ppc ppc64 x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-exit.patch
	sed -i Makefile -e 's| -o | ${LDFLAGS}&|g' || die "sed Makefile"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin geekcode || die
	dodoc CHANGES README geekcode.txt
}
