# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-expat/ocaml-expat-0.9.1.ebuild,v 1.5 2009/09/28 16:53:50 betelgeuse Exp $

EAPI="2"

inherit findlib eutils

IUSE="doc +ocamlopt test"

DESCRIPTION="OCaml bindings for expat"
SRC_URI="http://www.xs4all.nl/~mmzeeman/ocaml/${P}.tar.gz"
HOMEPAGE="http://www.xs4all.nl/~mmzeeman/ocaml/"

RDEPEND="dev-libs/expat
	>=dev-lang/ocaml-3.10.2[ocamlopt?]"

DEPEND="${RDEPEND}
	test? ( dev-ml/ounit )"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~x86"

src_prepare(){
	epatch "${FILESDIR}/${P}-test.patch"
}

src_compile() {
	emake depend || die "make depend failed"
	emake all || die "make failed"
	if use ocamlopt; then
		emake allopt || die "failed to build native code programs"
	fi
}

src_test() {
	emake test || die "bytecode tests failed"
	if use ocamlopt; then
		emake testopt || die "native code tests failed"
	fi
}
src_install() {
	findlib_src_preinst
	emake install || die

	if use doc ; then
		dohtml -r doc/html/*
	fi
	dodoc README || die
}
