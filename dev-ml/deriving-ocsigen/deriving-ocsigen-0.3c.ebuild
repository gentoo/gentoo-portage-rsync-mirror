# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/deriving-ocsigen/deriving-ocsigen-0.3c.ebuild,v 1.2 2013/07/23 17:39:43 aballier Exp $

EAPI=5

inherit findlib

DESCRIPTION="A deriving library for Ocsigen"
HOMEPAGE="http://ocsigen.org"
SRC_URI="http://www.ocsigen.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt type-conv"

DEPEND=">=dev-lang/ocaml-3.12:=[ocamlopt?]
	type-conv? ( >=dev-ml/type-conv-108:= )"
RDEPEND="${DEPEND}"

src_prepare() {
	find . -type f -exec sed -i 's/type-conv/type_conv/g' {} +
}

src_configure() {
	use type-conv || echo "TYPECONV :=" >> Makefile.config
}

src_compile() {
	if use ocamlopt; then
		emake
	else
		emake byte
	fi
}

src_test() {
	emake tests
}

src_install() {
	findlib_src_preinst
	if use ocamlopt; then
		emake install
	else
		emake install-byte
	fi
	dodoc CHANGES README
}
