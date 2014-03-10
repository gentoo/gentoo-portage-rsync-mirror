# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sbd/sbd-1.37-r1.ebuild,v 1.4 2014/03/10 20:15:19 swegener Exp $

EAPI="5"

inherit toolchain-funcs

DESCRIPTION="Netcat-clone, designed to be portable and offer strong encryption"
HOMEPAGE="http://tigerteam.se/dl/sbd/"
SRC_URI="http://tigerteam.se/dl/sbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i Makefile \
		-e '/ -o /{
			s| $(UNIX_LDFLAGS) $(LDFLAGS)||g;s|$(CFLAGS)|& $(LDFLAGS)|g
			}' \
		|| die "sed Makefile"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		unix
}

src_install() {
	dobin sbd
	dodoc CHANGES README
}
