# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-admin/flask-admin-1.0.6.ebuild,v 1.1 2013/08/17 04:41:14 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

RESTRICT="test" # we're still missing some of the dependencies

MY_PN="Flask-Admin"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple and extensible admin interface framework for Flask"
HOMEPAGE="https://pypi.python.org/pypi/Flask-Admin"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/flask-wtf[${PYTHON_USEDEP}]
		dev-python/flask-pymongo[${PYTHON_USEDEP}]
		dev-python/flask-peewee[${PYTHON_USEDEP}]
	)
	"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}
