# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hexdump-esr/hexdump-esr-1.7.ebuild,v 1.5 2012/09/25 03:11:29 blueness Exp $

EAPI=4

inherit toolchain-funcs

MY_P=${P/-esr/}

DESCRIPTION="Eric Raymond's hex dumper"
HOMEPAGE="http://www.catb.org/~esr/hexdump/"
SRC_URI="http://www.catb.org/~esr/hexdump/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i Makefile \
		-e "s|-O |${CFLAGS} ${LDFLAGS} |g" \
		|| die "sed Makefile"
	tc-export CC
}

src_install() {
	newbin hexdump hexdump-esr
	newman hexdump.1 hexdump-esr.1
	dodoc README
	dosym hexdump-esr /usr/bin/hex
}
