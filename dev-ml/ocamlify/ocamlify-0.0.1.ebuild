# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlify/ocamlify-0.0.1.ebuild,v 1.3 2013/02/07 14:13:35 aballier Exp $

EAPI=5

OASIS_NO_DEBUG=1

inherit oasis

DESCRIPTION="OCamlify allows to create OCaml source code by including whole file into OCaml string or string list"
HOMEPAGE="http://forge.ocamlcore.org/projects/ocamlify"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/379/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"
IUSE=""

DOCS=( "README.txt" "AUTHORS.txt" )
