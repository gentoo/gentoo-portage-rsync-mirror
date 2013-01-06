# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/bin-prot/bin-prot-108.00.01.ebuild,v 1.2 2012/07/09 20:51:07 ulm Exp $

EAPI=3

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="A binary protocol generator"
HOMEPAGE="http://ocaml.janestreet.com/?q=node/13"
SRC_URI="http://bitbucket.org/yminsky/ocaml-core/downloads/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND=">=dev-ml/ounit-1.0.2
	>=dev-ml/type-conv-3.0.5"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base dev-texlive/texlive-latexextra )"

DOCS=( "README" "Changelog" )
S="${WORKDIR}/${MY_P}"

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
