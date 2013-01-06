# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ulex/ulex-1.1.ebuild,v 1.5 2009/11/25 09:40:08 maekke Exp $

EAPI="2"

inherit eutils findlib

DESCRIPTION="A lexer generator for unicode"
HOMEPAGE="http://www.cduce.org"
SRC_URI="http://www.cduce.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="+ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"

src_compile() {
	emake all || die "failed to build bytecode"
	if use ocamlopt; then
		emake all.opt || die "failed to build native code"
	fi
}

src_install() {
	findlib_src_install
	dodoc README CHANGES || die
}
