# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-re/ocaml-re-1.2.2.ebuild,v 1.1 2014/10/24 07:54:03 aballier Exp $

EAPI=5

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="Regular expression library for OCaml"
HOMEPAGE="http://github.com/ocaml/ocaml-re"
SRC_URI="https://github.com/ocaml/ocaml-re/archive/${P}.tar.gz"

LICENSE="LGPL-2-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
DOCS=( "CHANGES" "TODO.txt" "README.md" )
S="${WORKDIR}/${PN}-${P}"
