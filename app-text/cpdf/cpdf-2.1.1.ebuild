# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cpdf/cpdf-2.1.1.ebuild,v 1.3 2014/12/08 16:17:00 radhermit Exp $

EAPI=5

inherit findlib

DESCRIPTION="PDF command line tools"
HOMEPAGE="http://community.coherentpdf.com/ https://github.com/johnwhitington/cpdf-source/"
SRC_URI="https://github.com/johnwhitington/cpdf-source/archive/v${PV}.tar.gz -> ${P}.tar.gz"

# BSD is only for xmlm.ml
LICENSE="Coherent-Graphics BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-lang/ocaml:=
	~dev-ml/camlpdf-${PV}:="
DEPEND="${RDEPEND}"

RESTRICT="mirror bindist"

S=${WORKDIR}/${PN}-source-${PV}

src_compile() {
	# parallel make issues
	emake -j1
}

src_install() {
	findlib_src_install

	dobin cpdf
	dodoc Changes README.md

	if use doc ; then
		dodoc cpdfmanual.pdf
		dohtml doc/cpdf/html/*
	fi
}
