# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlobject/sqlobject-1.4.1-r1.ebuild,v 1.2 2013/09/05 18:47:02 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite?"
inherit distutils-r1

MY_PN="SQLObject"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Object-Relational Manager, aka database wrapper"
HOMEPAGE="http://sqlobject.org/ http://pypi.python.org/pypi/SQLObject"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc firebird mysql postgres sqlite"

RDEPEND=">=dev-python/formencode-0.2.2[${PYTHON_USEDEP}]
		firebird? ( >=dev-python/kinterbasdb-3.0.2 )
		mysql? ( >=dev-python/mysql-python-0.9.2-r1[${PYTHON_USEDEP}] )
		postgres? ( dev-python/psycopg[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	if use doc; then
		pushd docs
		dodoc *.txt || die "dodoc failed"
		dohtml -r presentation-2004-11 || die "dohtml failed"
		insinto /usr/share/doc/${PF}
		doins -r europython || die "doins failed"
		popd
	fi
	distutils-r1_python_install_all
}
