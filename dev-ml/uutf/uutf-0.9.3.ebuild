# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/uutf/uutf-0.9.3.ebuild,v 1.1 2014/10/29 08:41:19 aballier Exp $

EAPI="5"

inherit findlib

DESCRIPTION="Non-blocking streaming Unicode codec for OCaml"
HOMEPAGE="http://erratique.ch/software/uutf"
SRC_URI="http://erratique.ch/software/uutf/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt doc"

RDEPEND=">=dev-lang/ocaml-3.12:=[ocamlopt?]"
DEPEND="${RDEPEND}"

src_compile() {
	pkg/build $(usex ocamlopt true false) || die
}

src_test() {
	if use ocamlopt ; then
		ocamlbuild tests.otarget || die
		cd _build/test || die
		./test.native || die
	else
		ewarn "Sorry, ${PN} tests require native support (ocamlopt)"
	fi
}

src_install() {
	# Can't use opam-installer here as it is an opam dep...
	findlib_src_preinst
	local nativelibs=""
	use ocamlopt && nativelibs="$(echo _build/src/uutf.cm{x,xa,xs} _build/src/uutf.a)"
	ocamlfind install uutf _build/pkg/META _build/src/uutf.mli _build/src/uutf.cm{a,i} ${nativelibs} || die
	newbin utftrip.$(usex ocamlopt native byte) utftrip
	dodoc CHANGES.md README.md
	use doc && dohtml -r doc/*
}
