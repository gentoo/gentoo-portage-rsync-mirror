# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pomap/pomap-2.9.9.ebuild,v 1.3 2009/08/14 17:54:32 maekke Exp $

EAPI="2"

inherit findlib eutils

DESCRIPTION="Partially Ordered Map ADT for O'Caml"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
LICENSE="LGPL-2.1"
RDEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"
DEPEND="${RDEPEND}"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="examples +ocamlopt"

src_compile() {
	cd "${S}/lib"
	emake -j1 byte-code-library || die "failed to build byte code library"
	if use ocamlopt; then
		emake -j1 native-code-library || die "failed to built nativde code library"
	fi
}

src_install () {
	use ocamlopt || export OCAMLFIND_INSTFLAGS="-optional"
	findlib_src_install

	# install documentation
	dodoc README.txt Changes

	#install examples
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
