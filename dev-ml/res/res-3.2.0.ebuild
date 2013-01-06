# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/res/res-3.2.0.ebuild,v 1.3 2009/08/14 18:15:11 maekke Exp $

EAPI="2"

inherit findlib eutils

DESCRIPTION="Resizable Array and Buffer modules for O'Caml"
HOMEPAGE="http://ocaml.info/home/ocaml_sources.html"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.gz"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc examples +ocamlopt"

src_prepare() {
	epatch "${FILESDIR}/${P}-noocamlopt.patch"
}

src_compile() {
	cd "${S}/lib"
	emake -j1 byte-code-library || die "failed to build byte code library"
	if use ocamlopt; then
		emake -j1 native-code-library || die "failed to built nativde code library"
	fi

	if use doc; then
		emake htdoc || die "failed to build documentation"
	fi
}

src_install () {
	cd "${S}/lib"
	findlib_src_preinst
	if use ocamlopt; then
		emake DESTDIR="${D}" libinstall || die
	else
		emake DESTDIR="${D}" libinstall-byte-code || die
	fi

	cd "${S}"
	# install documentation
	dodoc TODO README.txt Changelog

	if use doc; then
		dohtml lib/doc/res/html/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
