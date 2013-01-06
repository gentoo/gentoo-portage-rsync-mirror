# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcc/tcc-0.9.25.ebuild,v 1.3 2010/08/16 20:05:34 truedfx Exp $

inherit eutils toolchain-funcs

IUSE=""
DESCRIPTION="A very small C compiler for ix86/amd64"
HOMEPAGE="http://bellard.org/tcc/"
SRC_URI="http://download.savannah.nongnu.org/releases/tinycc/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
# Both tendra and tinycc install /usr/bin/tcc
RDEPEND="!dev-lang/tendra"

# Testsuite is broken, relies on gcc to compile
# invalid C code that it no longer accepts
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.9.25-flags.patch

	# Don't strip
	sed -i -e 's|$(INSTALL) -s|$(INSTALL)|' Makefile

	# Fix examples
	sed -i -e '1{
		i#! /usr/bin/tcc -run
		/^#!/d
	}' examples/ex*.c
	sed -i -e '1s/$/ -lX11/' examples/ex4.c
}

src_compile() {
	local myopts
	use x86 && myopts="--cpu=x86"
	use amd64 && myopts="--cpu=x86-64"
	econf ${myopts} --cc="$(tc-getCC)"
	emake || die "make failed"
}

src_install() {
	emake \
		bindir="${D}"/usr/bin \
		libdir="${D}"/usr/lib \
		tccdir="${D}"/usr/lib/tcc \
		includedir="${D}"/usr/include \
		docdir="${D}"/usr/share/doc/${PF} \
		mandir="${D}"/usr/share/man install || die "make install failed"
	dodoc Changelog README TODO VERSION
	dohtml tcc-doc.html
	exeinto /usr/share/doc/${PF}/examples
	doexe examples/ex*.c
}
