# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-mysql/ocaml-mysql-1.0.4.ebuild,v 1.4 2009/09/28 16:54:47 betelgeuse Exp $

EAPI="2"

inherit findlib eutils

IUSE="doc +ocamlopt"

DESCRIPTION="A package for ocaml that provides access to mysql databases."
SRC_URI="http://raevnos.pennmush.org/code/${PN}/${P}.tar.gz"
HOMEPAGE="http://raevnos.pennmush.org/code/ocaml-mysql/index.html"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	>=virtual/mysql-4.0"

RDEPEND="$DEPEND"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ppc x86"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.0.3-head.patch"
	epatch "${FILESDIR}/${PN}-1.0.3-shtool-r1.patch"
}

src_compile()
{
	emake all || die "make failed"
	if use ocamlopt; then
		emake opt || die "make opt failed"
	fi
}

src_install()
{
	findlib_src_preinst
	emake install || die "make install failed"

	use doc && dohtml -r doc/html/*
	dodoc CHANGES README VERSION || die
}
