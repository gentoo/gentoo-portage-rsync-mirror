# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pcre-ocaml/pcre-ocaml-7.0.2.ebuild,v 1.1 2012/10/10 11:46:25 aballier Exp $

EAPI=4

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="Perl Compatibility Regular Expressions for O'Caml"
HOMEPAGE="http://bitbucket.org/mmottl/pcre-ocaml"
SRC_URI="http://bitbucket.org/mmottl/pcre-ocaml/downloads/${P}.tar.gz"
LICENSE="LGPL-2.1-with-linking-exception"
IUSE="examples"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

RDEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	>=dev-libs/libpcre-4.5"
DEPEND="${RDEPEND}"

DOCS=( "AUTHORS.txt" "CHANGES.txt" "README.md" )

src_install() {
	oasis_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
