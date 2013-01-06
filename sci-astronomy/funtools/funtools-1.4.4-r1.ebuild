# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/funtools/funtools-1.4.4-r1.ebuild,v 1.2 2012/05/04 06:46:12 jdhore Exp $

EAPI=2
inherit eutils

DESCRIPTION="FITS library and utlities for astronomical images"
HOMEPAGE="http://www.cfa.harvard.edu/~john/funtools/"
SRC_URI="http://cfa-www.harvard.edu/~john/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="sys-libs/zlib
	sci-astronomy/wcstools
	sci-visualization/gnuplot"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefiles.patch
	sed -i \
		-e "s:\${LINK}:\${LINK} ${LDFLAGS}:" \
		mklib || die "sed for ldflags failed"
}

src_configure() {
	econf \
		--enable-shared \
		--enable-dl \
		--enable-mainlib \
		--with-wcslib="$(pkg-config --libs wcstools)" \
		--with-zlib=-lz \
		--with-tcl=-ltcl \
		WCS_INC="$(pkg-config --cflags wcstools)"
}

src_compile() {
	emake || die "emake failed"
	emake shtclfun || die "emake tcl functions failed"
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	# install missing includes
	insinto /usr/include/funtools/fitsy
	doins fitsy/*.h || die
	if use doc; then
		cd doc
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
		insinto /usr/share/doc/${PF}/html
		doins *.html *.c || die
	fi
}
