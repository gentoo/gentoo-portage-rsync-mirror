# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalx/clustalx-1.83-r2.ebuild,v 1.11 2012/10/24 19:29:39 ulm Exp $

EAPI=1

inherit toolchain-funcs eutils

DESCRIPTION="Graphical interface for the ClustalW multiple alignment program"
HOMEPAGE="http://www-igbmc.u-strasbg.fr/BioInfo/ClustalX/"
SRC_URI="ftp://ftp-igbmc.u-strasbg.fr/pub/ClustalX/clustalx1.83.sun.tar.gz"
LICENSE="public-domain"

SLOT="0"
KEYWORDS="~sparc"
IUSE=""

DEPEND="sci-biology/clustalw:1
	sci-biology/ncbi-tools
	>=x11-libs/motif-2.3:0
	x11-libs/libXpm"

S="${WORKDIR}/${PN}${PV}.sun"

pkg_setup() {
	if ! built_with_use sci-biology/ncbi-tools X; then
		echo
		eerror "ClustalX requires the Vibrant toolkit, which is part of the"
		eerror "optional X support in the \"sci-biology/ncbi-tools\" package."
		eerror "To install ClustalX on your system, first recompile"
		eerror "\"sci-biology/ncbi-tools\" with the \"X\" USE flag enabled,"
		eerror "then try to install ClustalX again."
		die "X support not enabled in \"sci-biology/ncbi-tools\""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp makefile.linux makefile
	sed -e "s/CC	= cc/CC	= $(tc-getCC)/" \
		-e "s/CFLAGS  = -c -O/CFLAGS  = -c ${CFLAGS}/" \
		-e "s/LFLAGS	= -O -lm/LFLAGS	= -lm ${CFLAGS}/" \
		-e "s%-I/usr/bio/src/ncbi/include%-I/usr/include/ncbi%" \
		-e "s%-L/usr/bio/src/ncbi/lib -L/usr/ccs/lib -L/usr/X11R6/lib%-L/usr/lib -L/usr/X11R6/lib%" \
		-i makefile || die
	sed -i -e "s%clustalx_help%/usr/share/doc/${PF}/clustalx_help%" clustalx.c || die
	sed -i -e "s%clustalw.doc%../clustalw.doc%" clustalx.html || die
}

src_compile() {
	make || die
}

src_install() {
	dobin clustalx

	dodoc README_X
	dohtml clustalx.html

	insinto /usr/share/doc/${PF}
	doins clustalx_help clustalw.doc
}
