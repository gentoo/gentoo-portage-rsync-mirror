# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/extlib/extlib-1.5.3.ebuild,v 1.4 2012/11/20 20:50:36 ago Exp $

EAPI="2"

inherit findlib eutils

DESCRIPTION="Standard library extensions for O'Caml"
HOMEPAGE="http://code.google.com/p/ocaml-extlib/"
SRC_URI="http://ocaml-extlib.googlecode.com/files/${P}.tar.gz"
LICENSE="LGPL-2.1"
DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc +ocamlopt"

src_compile() {
	emake all || die "failed to build"
	if use ocamlopt; then
		emake opt || die "failed to build"
	fi

	if use doc; then
		emake doc || die "failed to create documentation"
	fi
}

src_install () {
	findlib_src_install

	# install documentation
	dodoc README.txt || die

	if use doc; then
		dohtml doc/* || die
	fi
}
