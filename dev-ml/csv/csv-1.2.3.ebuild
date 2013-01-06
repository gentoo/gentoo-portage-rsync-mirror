# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/csv/csv-1.2.3.ebuild,v 1.1 2012/09/09 19:40:05 aballier Exp $

EAPI=4

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="A pure OCaml library to read and write CSV files"
HOMEPAGE="http://forge.ocamlcore.org/projects/csv/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/978/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( "README.txt" "AUTHORS.txt" )
