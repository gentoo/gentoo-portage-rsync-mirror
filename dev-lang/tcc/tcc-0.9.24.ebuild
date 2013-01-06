# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcc/tcc-0.9.24.ebuild,v 1.1 2009/01/04 21:03:25 patrick Exp $

inherit eutils

IUSE=""
DESCRIPTION="A very small C compiler for ix86"
HOMEPAGE="http://bellard.org/tcc/"
SRC_URI="http://download.savannah.nongnu.org/releases/tinycc/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~x86"

DEPEND=""
# Both tendra and tinycc install /usr/bin/tcc
RDEPEND="!dev-lang/tendra"

# Testsuite is broken, relies on gcc to compile
# invalid C code that it no longer accepts
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#epatch "${FILESDIR}"/${PN}-0.9.23-anonunion.patch
	#epatch "${FILESDIR}"/${PN}-0.9.23-asneeded.patch
	#epatch "${FILESDIR}"/${PN}-0.9.23-nxbit.patch

	# Don't strip
	sed -i -e 's|$(INSTALL) -s|$(INSTALL)|' Makefile

	# Fix examples
	sed -i -e '1{
		i#! /usr/bin/tcc -run
		/^#!/d
	}' examples/ex*.c
	sed -i -e '1s/$/ -lX11/' examples/ex4.c
}

src_install() {
	#autoconf for the package does not create dirs if they are missing for some reason
	dodir /usr/bin
	dodir /usr/lib/tcc
	dodir /usr/share/man/man1
	dodir /usr/include
	dodir /usr/share/doc/${PF}
	make \
		bindir="${D}"/usr/bin \
		libdir="${D}"/usr/lib \
		tccdir="${D}"/usr/lib/tcc \
		includedir="${D}"/usr/include \
		docdir="${D}"/usr/share/doc/${PF} \
		mandir="${D}"/usr/share/man install || die
	dodoc Changelog README TODO VERSION COPYING
	dohtml tcc-doc.html
	exeinto /usr/share/doc/${PF}/examples
	doexe examples/ex*.c
}
