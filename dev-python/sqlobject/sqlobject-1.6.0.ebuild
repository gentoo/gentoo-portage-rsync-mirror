# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlobject/sqlobject-1.6.0.ebuild,v 1.1 2014/05/20 14:48:56 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite?"
inherit distutils-r1

MY_PN="SQLObject"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Object-Relational Manager, aka database wrapper"
HOMEPAGE="http://sqlobject.org/ http://pypi.python.org/pypi/SQLObject"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc firebird mysql postgres sqlite"

RDEPEND=">=dev-python/formencode-1.1.1[${PYTHON_USEDEP}]
		firebird? ( dev-python/kinterbasdb )
		mysql? ( dev-python/mysql-python[${PYTHON_USEDEP}] )
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
