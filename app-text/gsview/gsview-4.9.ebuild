# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gsview/gsview-4.9.ebuild,v 1.8 2012/02/16 18:24:09 phajdan.jr Exp $

EAPI="3"

inherit eutils toolchain-funcs

MY_PV="${PV/.}"

DESCRIPTION="gsView PostScript and PDF viewer"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/gsview/"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/ghostgum/gsv${MY_PV}src.zip"

IUSE="doc"
SLOT="0"
LICENSE="Aladdin"
KEYWORDS="amd64 hppa ppc x86 ~amd64-linux ~x86-linux"

RDEPEND="x11-libs/gtk+:1
	app-text/epstool
	app-text/pstotext
	app-text/ghostscript-gpl"
DEPEND="app-arch/unzip
	x11-libs/gtk+:1"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	epatch "${FILESDIR}"/${P}-libdl.patch
	tc-export CC
}

src_compile() {
	ln -sf srcunx/unx.mak Makefile || die

	## respect CFLAGS
	sed -i -e "s:^CFLAGS=-O :CFLAGS=${CFLAGS} :g" Makefile || die
	sed -i -e "s:GSVIEW_DOCPATH:\"${EPREFIX}/usr/share/doc/${PF}/html/\":" srcunx/gvx.c || die

	## run Makefile
	# bug #283165
	emake -j1 || die "Error compiling files."
}

src_install() {
	dobin bin/gsview || die

	doman srcunx/gsview.1 || die

	dodoc gsview.css cdorder.txt regorder.txt || die

	if use doc
	then
		dobin "${FILESDIR}"/gsview-help || die
		dohtml *.htm bin/*.htm || die
	fi

	insinto /etc/gsview
	doins src/printer.ini || die

	make_desktop_entry gsview Gsview "" "Office" ||
		die "Couldn't make gsview desktop entry"
}
