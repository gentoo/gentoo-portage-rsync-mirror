# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamldsort/ocamldsort-0.16.0.ebuild,v 1.2 2013/03/10 09:47:52 aballier Exp $

EAPI=5

DESCRIPTION="A dependency sorter for OCaml source files"
HOMEPAGE="http://dimitri.mutu.net/ocaml.html"
SRC_URI="ftp://quatramaran.ens.fr/pub/ara/ocamldsort/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.12:="
RDEPEND="${DEPEND}"

src_compile() {
	emake -j1
}

src_install() {
	emake BINDIR="${ED}/usr/bin" MANDIR="${ED}/usr/share/man" install
	dodoc README THANKS Changes
}
