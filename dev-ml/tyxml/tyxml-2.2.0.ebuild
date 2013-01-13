# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/tyxml/tyxml-2.2.0.ebuild,v 1.1 2013/01/13 19:50:06 aballier Exp $

EAPI=4

inherit eutils findlib

DESCRIPTION="A libary to build xml trees typechecked by OCaml"
HOMEPAGE="http://ocsigen.org/tyxml/"
SRC_URI="http://www.ocsigen.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc ocamlduce +ocamlopt"

DEPEND="
	>=dev-lang/ocaml-3.12[ocamlopt?]
	dev-ml/ocamlnet
	ocamlduce? ( dev-ml/ocamlduce )"
RDEPEND="${DEPEND}"

src_prepare() {
	export myopts="OCAMLDUCE=$(usex ocamlduce yes no)"
}

src_compile() {
	if use ocamlopt; then
		emake "$myopts"
	else
		emake "$myopts" byte
	fi
	use doc && emake doc "$myopts"
}

src_install() {
	findlib_src_preinst
	if use ocamlopt; then
		emake DESTIR="${D}" "$myopts" install
	else
		emake DESTIR="${D}" "$myopts" install-byte
	fi
	dodoc CHANGES README
	use doc && dohtml -r doc/api-html
}
