# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/cudf/cudf-0.7.ebuild,v 1.2 2014/10/24 08:35:05 aballier Exp $

EAPI=5

inherit multilib

DESCRIPTION="Library to parse, pretty print, and evaluate CUDF documents"
HOMEPAGE="http://www.mancoosi.org/cudf/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/33593/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"

RDEPEND="
	>=dev-lang/ocaml-3.12:=[ocamlopt?]
	dev-ml/extlib:=
	dev-libs/glib:2
"
DEPEND="${RDEPEND}
	test? ( dev-ml/ounit )
	dev-ml/findlib
	dev-lang/perl
"

src_compile() {
	emake -j1 all
	emake c-lib
	if use ocamlopt ; then
		emake -j1 opt
		emake c-lib-opt
	fi
}

src_test() {
	emake test
	emake c-lib-test
}

src_install() {
	emake DESTDIR="${ED}" LIBDIR="/usr/$(get_libdir)" install
	dodoc BUGS ChangeLog README TODO
}
