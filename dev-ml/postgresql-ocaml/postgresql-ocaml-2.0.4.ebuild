# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/postgresql-ocaml/postgresql-ocaml-2.0.4.ebuild,v 1.2 2013/12/24 12:42:22 ago Exp $

EAPI=5

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="A package for ocaml that provides access to PostgreSQL databases."
SRC_URI="http://bitbucket.org/mmottl/postgresql-ocaml/downloads/${P}.tar.gz"
HOMEPAGE="http://bitbucket.org/mmottl/postgresql-ocaml"
IUSE="examples"

DEPEND="dev-db/postgresql-base
	dev-db/postgresql-server"
RDEPEND="${DEPEND}"

SLOT="0/${PV}"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc x86"

DOCS=( "AUTHORS.txt" "CHANGES.txt" "README.md" )

src_install() {
	oasis_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
