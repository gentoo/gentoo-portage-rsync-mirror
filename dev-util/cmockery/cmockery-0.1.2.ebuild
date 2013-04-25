# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmockery/cmockery-0.1.2.ebuild,v 1.12 2013/04/25 18:29:10 radhermit Exp $

EAPI=4

inherit autotools

DESCRIPTION="A lightweight library to simplify writing unit tests for C applications"
HOMEPAGE="http://code.google.com/p/cmockery/"
SRC_URI="http://cmockery.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ppc ppc64 ~s390 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="examples static-libs"

src_prepare() {
	sed -i "/dist_doc_DATA/{N;d}" Makefile.am || die
	sed -i "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" configure.ac || die
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	dohtml doc/*

	if use examples ; then
		docinto examples
		dodoc src/example/*
		docompress -x /usr/share/doc/${PF}/examples
	fi

	use static-libs || find "${ED}" -name '*.la' -exec rm -f '{}' +
}
