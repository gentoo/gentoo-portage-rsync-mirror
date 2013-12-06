# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/samtools/samtools-0.1.18-r3.ebuild,v 1.2 2013/12/06 12:44:16 jlec Exp $

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="Utilities for SAM (Sequence Alignment/Map), a format for large nucleotide sequence alignments"
HOMEPAGE="http://samtools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
IUSE="examples"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x64-macos"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed \
		-e '/^CC/s:=:?=:g' \
		-e "/^LIBCURSES/s:=.*$:= $(pkg-config --libs ncurses):g" \
		-e '/^CFLAGS=/s:=:?=:' \
		-e "s/\$(CC) \$(CFLAGS)/& \$(LDFLAGS)/g" \
		-e "s/-shared/& \$(LDFLAGS)/" \
		-i "${S}"/{bcftools,misc,}/Makefile || die #358563
	sed -i 's~/software/bin/python~/usr/bin/env python~' "${S}"/misc/varfilter.py || die

	tc-export CC
}

src_compile() {
	emake dylib
	emake
}

src_install() {
	dobin samtools $(find bcftools misc -type f -executable)

	dolib.so libbam.so.1
	dosym libbam.so.1 /usr/$(get_libdir)/libbam.so

	insinto /usr/include/bam
	doins bam.h bgzf.h faidx.h kaln.h khash.h kprobaln.h kseq.h ksort.h sam.h

	doman ${PN}.1
	dodoc AUTHORS ChangeLog NEWS

	if use examples; then
		insinto /usr/share/${PN}
		doins -r examples
	fi
}
