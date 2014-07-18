# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmba/libmba-0.9.1-r1.ebuild,v 1.4 2014/07/18 21:36:23 jer Exp $

EAPI=5
inherit eutils multilib toolchain-funcs

DESCRIPTION="A library of generic C modules"
LICENSE="MIT"
HOMEPAGE="http://www.ioplex.com/~miallen/libmba/"
SRC_URI="${HOMEPAGE}dl/${P}.tar.gz"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

src_prepare() {
	use static-libs && export STATIC="1"
	epatch "${FILESDIR}"/${P}-qa.patch

	tc-export CC
	sed -i -e "s:gcc:${CC}:g" mktool.c || die
}

src_compile() {
	emake LIBDIR="$(get_libdir)"
}

src_install() {
	default

	dodoc README.txt docs/*.txt
	dohtml -r docs/*.html docs/www/* docs/ref

	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
