# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlobject/sqlobject-1.2.2.ebuild,v 1.1 2012/03/09 09:10:42 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="SQLObject"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Object-Relational Manager, aka database wrapper"
HOMEPAGE="http://sqlobject.org/ http://pypi.python.org/pypi/SQLObject"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc firebird mysql postgres sqlite"

RDEPEND=">=dev-python/formencode-0.2.2
		firebird? ( >=dev-python/kinterbasdb-3.0.2 )
		mysql? ( >=dev-python/mysql-python-0.9.2-r1 )
		postgres? ( dev-python/psycopg )
		sqlite? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite ) )"
DEPEND="${RDEPEND}
		dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	if use doc; then
		pushd docs
		dodoc *.txt || die "dodoc failed"
		dohtml -r presentation-2004-11 || die "dohtml failed"
		insinto /usr/share/doc/${PF}
		doins -r europython || die "doins failed"
		popd
	fi
}
