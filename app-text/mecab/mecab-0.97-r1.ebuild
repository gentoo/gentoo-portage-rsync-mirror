# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mecab/mecab-0.97-r1.ebuild,v 1.8 2010/01/14 00:18:06 jer Exp $

IUSE="unicode"

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools

DESCRIPTION="Yet Another Part-of-Speech and Morphological Analyzer"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
KEYWORDS="amd64 ~arm hppa ia64 ppc ppc64 sparc x86"
SLOT="0"
RESTRICT="test"

DEPEND="dev-lang/perl"
PDEPEND=">=app-dicts/mecab-ipadic-2.7.0.20070610"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/CFLAGS/s/-O3/${CFLAGS}/" \
		-e "/CXXFLAGS/s/-O3/${CXXFLAGS}/" \
		configure.in || die
	eautoreconf
}

src_compile() {

	local myconf

	use unicode && myconf="${myconf} --with-charset=utf8"

	econf ${myconf} || die
	emake || die

}

src_install() {

	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README || die
	dohtml -r doc || die

}
