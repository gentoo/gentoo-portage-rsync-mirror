# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/sexplib/sexplib-108.00.01.ebuild,v 1.1 2012/06/30 15:03:03 aballier Exp $

EAPI=3

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="Library for automated conversion of OCaml-values to and from S-expressions"
HOMEPAGE="http://bitbucket.org/yminsky/ocaml-core/wiki/Home"
SRC_URI="http://bitbucket.org/yminsky/ocaml-core/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-ml/type-conv-108.00.01"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base dev-texlive/texlive-latexextra )"

DOCS=( "README" "Changelog" )

src_compile() {
	oasis_src_compile
	if use doc ; then
		cd "${S}/doc"
		pdflatex README || die
		pdflatex README || die
	fi
}

src_install() {
	oasis_src_install

	if use doc; then
		dodoc doc/README.pdf || die
	fi
}
