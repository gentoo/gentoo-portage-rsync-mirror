# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pgocaml/pgocaml-1.6.ebuild,v 1.2 2012/11/21 11:59:55 aballier Exp $

EAPI=4

inherit eutils

DESCRIPTION="PG'OCaml is a set of OCaml bindings for the PostgreSQL database"
HOMEPAGE="http://pgocaml.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/922/${P}.tgz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc batteries"

DEPEND="dev-ml/calendar
	!batteries? ( dev-ml/extlib )
	batteries? ( dev-ml/batteries )
	dev-ml/csv
	dev-ml/pcre-ocaml
	>=dev-lang/ocaml-3.10[ocamlopt]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-test.patch"
	epatch "${FILESDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-parallel-make.patch"
}

src_configure() {
	echo "DESTDIR := \"${ED}/\"" >> Makefile.config
	use batteries && echo "USE_BATTERIES := yes" >> Makefile.config
	emake depend
}

src_compile() {
	use doc && emake doc
	emake
}

src_test() {
	local default_pguser="postgres"
	local default_pghost="localhost"
	local default_pgport=""

	einfo "The tests need a running PostgreSQL server."
	einfo "Test requires PGUSER or/and PGPORT or/and PGHOST to be set."
	einfo "If there are not, defaults are:"
	einfo "    PGUSER=${default_pguser}"
	einfo "    PGHOST=${default_pghost}"
	einfo "    PGPORT=${default_pgport}"
	einfo "Define them at the command line or in:"
	einfo "    ${EROOT%/}/etc/pgocaml_test_env"

	local user_defined_pguser=$PGUSER
	local user_defined_pghost=$PGHOST
	local user_defined_pgport=$PGPORT

	unset PGUSER
	unset PGHOST
	unset PGPORT

	if [[ -f ${EROOT%/}/etc/pgocaml_test_env ]]; then
		source "${EROOT%/}/etc/pgocaml_test_env"
	fi
	[[ -n $PGUSER ]] && export PGUSER
	[[ -n $PGHOST ]] && export PGHOST
	[[ -n $PGPORT ]] && export PGPORT

	[[ -n $user_defined_pguser ]] && export PGUSER=$user_defined_pguser
	[[ -n $user_defined_pghost ]] && export PGHOST=$user_defined_pghost
	[[ -n $user_defined_pgport ]] && export PGPORT=$user_defined_pgport

	[[ -z $PGUSER ]] && export PGUSER=${default_pguser}
	[[ -z $PGHOST ]] && export PGHOST=${default_pghost}
	[[ -z $PGPORT ]] && export PGPORT=${default_pgport}

	einfo "PGUSER set to: ${PGUSER}"
	einfo "PGHOST set to: ${PGHOST}"
	einfo "PGPORT set to: ${PGPORT}"

	emake test
}

src_install() {
	emake install
	dodoc BUGS.txt CONTRIBUTORS.txt HOW_IT_WORKS.txt README.txt \
		CHANGELOG.txt README.profiling
	use doc && dohtml -r html
}
