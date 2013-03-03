# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/xstr/xstr-0.2.1.ebuild,v 1.5 2013/03/03 14:57:49 aballier Exp $

EAPI=5

inherit findlib

DESCRIPTION="Thread-safe implementation of string searching/matching/splitting."
HOMEPAGE="http://www.ocaml-programming.de/packages/"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.10:=[ocamlopt]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile()
{
	make all || die
	make opt || die
}

src_install()
{
	findlib_src_install
	dodoc README RELEASE
}
