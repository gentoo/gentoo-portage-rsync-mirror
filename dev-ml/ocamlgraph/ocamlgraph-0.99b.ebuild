# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlgraph/ocamlgraph-0.99b.ebuild,v 1.5 2009/09/28 16:51:57 betelgeuse Exp $

EAPI="2"

inherit findlib eutils

DESCRIPTION="O'Caml Graph library"
HOMEPAGE="http://www.lri.fr/~filliatr/ocamlgraph/"
SRC_URI="http://www.lri.fr/~filliatr/ftp/ocamlgraph/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	doc? ( dev-tex/hevea dev-ml/ocamlweb )
	gtk? ( dev-ml/lablgtk[gnomecanvas,ocamlopt?] )"
IUSE="doc examples gtk +ocamlopt"

src_prepare() {
	epatch "${FILESDIR}/${P}-installfindlib.patch"
}

src_compile() {
	emake -j1 || die "failed to build"

	if use doc;	then
		emake doc || die "making documentation failed"
	fi
	if use gtk; then
		emake -j1 editor || die "compiling editor failed"
	fi
}

src_install() {
	findlib_src_preinst
	emake install-findlib || die "make install failed"

	if use gtk; then
		if use ocamlopt; then
			newbin editor/editor.opt ocamlgraph_editor || die "failed to install ocamlgraph_editor"
		else
			newbin editor/editor.byte ocamlgraph_editor || die "failed to install ocamlgraph_editor"
		fi
	fi
	dodoc README CREDITS FAQ CHANGES || die
	if use doc; then
		dohtml doc/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
