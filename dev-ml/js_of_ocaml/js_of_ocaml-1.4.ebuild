# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/js_of_ocaml/js_of_ocaml-1.4.ebuild,v 1.1 2013/12/11 19:19:07 aballier Exp $

EAPI=5

inherit findlib

DESCRIPTION="A compiler from OCaml bytecode to javascript"
HOMEPAGE="http://ocsigen.org/js_of_ocaml/"
SRC_URI="http://www.ocsigen.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt doc +deriving-ocsigen"

DEPEND=">=dev-lang/ocaml-3.12:=[ocamlopt?]
	>=dev-ml/lwt-2.3.0:=
	deriving-ocsigen? ( >=dev-ml/deriving-ocsigen-0.3:= )"
RDEPEND="${DEPEND}"

src_configure() {
	use ocamlopt || echo "BEST := byte" >> Makefile.conf
	use deriving-ocsigen || echo "DERIVING :=" >> Makefile.conf
}

src_compile() {
	emake
	use doc && emake doc
}

src_install() {
	findlib_src_preinst
	emake BINDIR="${ED}/usr/bin/" install
	dodoc CHANGES README
	use doc && dohtml -r doc/api-html
}
