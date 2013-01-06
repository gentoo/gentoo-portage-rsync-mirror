# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-data-notation/ocaml-data-notation-0.0.10.ebuild,v 1.1 2012/10/08 11:32:42 aballier Exp $

EAPI=3

OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="This project uses type-conv to dump OCaml data structure using OCaml data notation"
HOMEPAGE="http://forge.ocamlcore.org/projects/odn"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/1029/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-ml/type-conv-108.07.01"
DEPEND="${RDEPEND}
	test? ( dev-ml/ounit[ocamlopt?] dev-ml/ocaml-fileutils[ocamlopt?] )"

DOCS=( "README.txt" "AUTHORS.txt" "CHANGES.txt" )

src_prepare() {
	sed -i -e 's/type-conv/type_conv/' tests/test.ml || die
}
