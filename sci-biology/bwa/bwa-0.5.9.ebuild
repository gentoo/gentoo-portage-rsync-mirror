# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bwa/bwa-0.5.9.ebuild,v 1.1 2011/05/01 09:19:52 jlec Exp $

EAPI=2

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Burrows-Wheeler Alignment Tool, a fast short genomic sequence aligner"
HOMEPAGE="http://bio-bwa.sourceforge.net/"
SRC_URI="mirror://sourceforge/bio-bwa/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86 ~x64-macos"

src_prepare() {
	sed -e "s/\$(CC) \$(CFLAGS)/\$(CC) \$(LDFLAGS) \$(CFLAGS)/" \
		-i "${S}"/Makefile || die #336348
	append-flags -pthread
}

src_compile() {
	emake -e CC="$(tc-getCC)" || die
}

src_install() {
	dobin bwa || die
	doman bwa.1 || die
	exeinto /usr/share/${PN}
	doexe solid2fastq.pl || die
	doexe qualfa2fq.pl || die
	dodoc ChangeLog NEWS || die
}
