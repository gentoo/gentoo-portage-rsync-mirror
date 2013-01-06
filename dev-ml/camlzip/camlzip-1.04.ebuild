# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlzip/camlzip-1.04.ebuild,v 1.4 2011/04/27 17:58:49 angelos Exp $

EAPI="2"

inherit findlib eutils

IUSE="+ocamlopt"

DESCRIPTION="Compressed file access ML library (ZIP, GZIP and JAR)"
HOMEPAGE="http://cristal.inria.fr/~xleroy/software.html#camlzip"
SRC_URI="http://caml.inria.fr/distrib/bazar-ocaml/${P}.tar.gz"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

RDEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
		>=sys-libs/zlib-1.1.3"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.03-Makefile-findlib.patch"
	sed -e "s/VERSION/${PV}/" "${FILESDIR}/META" >> META
}

src_compile() {
	emake all || die "Failed at compilation step !!!"
	if use ocamlopt; then
		emake allopt || die "Failed at ML compilation step !!!"
	fi
}

src_install() {
	findlib_src_install

	dodoc README Changes
}
