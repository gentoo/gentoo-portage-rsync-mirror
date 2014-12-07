# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlpdf/camlpdf-2.1.1.ebuild,v 1.2 2014/12/07 18:37:48 radhermit Exp $

EAPI=5

inherit findlib

DESCRIPTION="OCaml library for reading, writing, and modifying PDF files"
HOMEPAGE="https://github.com/johnwhitington/camlpdf/"
SRC_URI="https://github.com/johnwhitington/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="dev-lang/ocaml:="
DEPEND="${RDEPEND}"

src_compile() {
	# parallel make bugs
	emake -j1
}

src_install() {
	findlib_src_install
	dodoc Changes README.md

	if use doc ; then
		dodoc introduction_to_camlpdf.pdf
		dohtml doc/camlpdf/html/*
	fi

	use examples && dodoc -r examples
}
