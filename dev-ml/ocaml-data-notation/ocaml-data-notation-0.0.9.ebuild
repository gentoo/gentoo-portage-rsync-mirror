# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-data-notation/ocaml-data-notation-0.0.9.ebuild,v 1.1 2012/07/07 16:20:06 aballier Exp $

EAPI=3

OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="This project uses type-conv to dump OCaml data structure using OCaml data notation"
HOMEPAGE="http://forge.ocamlcore.org/projects/odn"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/881/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-ml/type-conv-3.0.5"
DEPEND="${RDEPEND}
	test? ( dev-ml/ounit[ocamlopt?] dev-ml/ocaml-fileutils[ocamlopt?] )"

DOCS=( "README.txt" "AUTHORS.txt" "CHANGES.txt" )
