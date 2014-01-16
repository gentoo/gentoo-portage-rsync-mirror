# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pygresql/pygresql-4.0.ebuild,v 1.8 2014/01/16 20:17:22 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

MY_P="PyGreSQL-${PV}"

DESCRIPTION="A Python interface for the PostgreSQL database."
HOMEPAGE="http://www.pygresql.org/"
SRC_URI="ftp://ftp.pygresql.org/pub/distrib/${MY_P}.tgz"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND="dev-db/postgresql-base"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="docs/*.txt"
PYTHON_MODNAME="pg.py pgdb.py"

src_install() {
	distutils_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}/tutorial
		doins tutorial/* || die "doins failed"
		dohtml docs/*.{html,css} || die "dohtml failed"
	fi
}
