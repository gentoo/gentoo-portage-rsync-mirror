# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/samtools/samtools-0.1.19.ebuild,v 1.1 2013/09/20 17:15:46 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils multilib python-r1 toolchain-funcs

DESCRIPTION="Utilities for SAM (Sequence Alignment/Map), a format for large nucleotide sequence alignments"
HOMEPAGE="http://samtools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="examples"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CDEPEND="sys-libs/ncurses"
RDEPEND="${CDEPEND}
	dev-lang/lua
	dev-lang/perl"
DEPEND="${CDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-buildsystem.patch

	sed -i 's~/software/bin/python~/usr/bin/env python~' "${S}"/misc/varfilter.py || die

	tc-export CC AR
}

src_compile() {
	local _ncurses="$(pkg-config --libs ncurses)"
	emake dylib LIBCURSES="${_ncurses}"
	emake LIBCURSES="${_ncurses}"
}

src_install() {
	dobin samtools $(find bcftools misc -type f -executable)

	python_replicate_script "${ED}"/usr/bin/varfilter.py

	dolib.so libbam.so.1
	dosym libbam.so.1 /usr/$(get_libdir)/libbam.so

	insinto /usr/include/bam
	doins *.h

	doman ${PN}.1
	dodoc AUTHORS NEWS

	if use examples; then
		insinto /usr/share/${PN}
		doins -r examples
	fi
}
