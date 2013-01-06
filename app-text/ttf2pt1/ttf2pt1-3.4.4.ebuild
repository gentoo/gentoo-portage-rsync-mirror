# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ttf2pt1/ttf2pt1-3.4.4.ebuild,v 1.4 2009/10/10 15:24:52 armin76 Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="True Type Font to Postscript Type 1 Converter"
HOMEPAGE="http://ttf2pt1.sourceforge.net/"
SRC_URI="mirror://sourceforge/ttf2pt1/${P}.tgz"

LICENSE="ttf2pt1"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=media-libs/freetype-2.0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-Makefile.patch"
	epatch "${FILESDIR}/${PN}-3.4.0-man-pages.diff"
	epatch "${FILESDIR}/${P}-freetype.patch"

	sed -i -e "/^CC=/ { s:gcc:$(tc-getCC): }" Makefile
	sed -i -e "/^CFLAGS_SYS=/ { s:-O.*$:${CFLAGS}: }" Makefile
	sed -i -e "/^LIBS_FT=/ { s:-L/usr/lib:-L/usr/$(get_libdir): }" Makefile
	sed -i -e "/^LIBXDIR =/ { s:libexec:$(get_libdir): }" Makefile
}

src_compile() {
	emake all || die
}

src_install() {
	emake INSTDIR=${D}/usr install || die
	dodir /usr/share/doc/${PF}/html
	cd ${D}/usr/share/ttf2pt1
	rm -r app other
	mv *.html ../doc/${PF}/html
	mv [A-Z]* ../doc/${PF}
	prepalldocs
}
