# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamldsort/ocamldsort-0.15.0.ebuild,v 1.3 2012/02/06 17:11:34 ranger Exp $

DESCRIPTION="A dependency sorter for OCaml source files"
HOMEPAGE="http://dimitri.mutu.net/ocaml.html"

SRC_URI="ftp://quatramaran.ens.fr/pub/ara/ocamldsort/${P}.tar.gz"

LICENSE="LGPL-2"

SLOT="0"

KEYWORDS="~amd64 ppc x86"

IUSE=""

DEPEND=">=dev-lang/ocaml-3.06"

src_compile() {
	econf
	emake -j1 || die
}

src_install() {
	emake BINDIR="${D}/usr/bin" MANDIR="${D}/usr/share/man" install || die "make install failed"
	dodoc README THANKS Changes
}
