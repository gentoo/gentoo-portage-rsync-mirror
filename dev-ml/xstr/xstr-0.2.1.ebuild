# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/xstr/xstr-0.2.1.ebuild,v 1.4 2012/12/14 11:17:18 ulm Exp $

inherit findlib

DESCRIPTION="Thread-safe implementation of string searching/matching/splitting."
HOMEPAGE="http://www.ocaml-programming.de/packages/"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND="$DEPEND"

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
