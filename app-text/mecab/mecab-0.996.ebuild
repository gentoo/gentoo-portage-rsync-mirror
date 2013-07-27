# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mecab/mecab-0.996.ebuild,v 1.7 2013/07/27 22:33:54 aballier Exp $

EAPI="5"
inherit autotools eutils

DESCRIPTION="Yet Another Part-of-Speech and Morphological Analyzer"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="http://mecab.googlecode.com/files/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
KEYWORDS="amd64 ~arm hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd"
SLOT="0"
IUSE="static-libs unicode"

DEPEND="dev-lang/perl
	virtual/libiconv"
RDEPEND=""
PDEPEND="|| (
		>=app-dicts/mecab-ipadic-2.7.0.20070610[unicode=]
		app-dicts/mecab-naist-jdic[unicode=]
	)"

src_prepare() {
	sed -i \
		-e "/CFLAGS/s/-O3/${CFLAGS}/" \
		-e "/CXXFLAGS/s/-O3/${CXXFLAGS}/" \
		configure.in || die
	epatch "${FILESDIR}/${PN}-0.98-iconv.patch"
	eautoreconf
}

src_configure() {
	local myconf

	use unicode && myconf="${myconf} --with-charset=utf8"

	econf \
		$(use_enable static-libs static) \
		${myconf}
}

src_install() {
	default

	if ! use static-libs ; then
		find "${ED}" -name '*.la' -delete
	fi

	dodoc AUTHORS README
	dohtml -r doc/*
}
