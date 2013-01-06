# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xdvipdfmx/xdvipdfmx-0.4.ebuild,v 1.11 2010/06/12 16:20:21 aballier Exp $

inherit eutils

DESCRIPTION="Extended dvipdfmx for use with XeTeX and other unicode TeXs."
HOMEPAGE="http://scripts.sil.org/svn-view/xdvipdfmx/"
SRC_URI="http://scripts.sil.org/svn-view/xdvipdfmx/TAGS/${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/freetype-2.0 virtual/latex-base"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-ft2-internals.patch"
}

src_compile() {
	chmod +x configure
#	sh ./configure --prefix=/usr \
	econf \
		--with-ft2lib=/usr/lib/libfreetype.so \
		--with-ft2include=/usr/include/freetype2 || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README doc/tug2003.pdf doc/CJK-CID.txt doc/images/dvipdfm-cjk.png doc/images/dvipdfmx-logo.png doc/images/rightarrow.png doc/images/right_triangle.png doc/images/dvipdfmx.png TODO BUGS AUTHORS
}
