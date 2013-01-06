# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-mysql/ocaml-mysql-1.1.1.ebuild,v 1.1 2012/05/23 23:36:02 aballier Exp $

EAPI="2"

inherit findlib eutils

IUSE="+ocamlopt"

DESCRIPTION="A package for ocaml that provides access to mysql databases."
SRC_URI="http://forge.ocamlcore.org/frs/download.php/870/${P}.tar.gz"
HOMEPAGE="http://ocaml-mysql.forge.ocamlcore.org/"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	sys-libs/zlib
	>=virtual/mysql-4.0"

RDEPEND="$DEPEND"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

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

	dodoc CHANGES README VERSION || die
}
