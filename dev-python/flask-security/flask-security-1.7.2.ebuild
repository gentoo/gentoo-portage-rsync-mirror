# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-security/flask-security-1.7.2.ebuild,v 1.1 2014/05/20 07:43:31 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="Flask-Security"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple security for Flask apps"
HOMEPAGE="http://pythonhosted.org/${MY_PN}/ https://pypi.python.org/pypi/${MY_PN}"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
# packages of this type require local running  instances of databases
# which then require connect to localhost
RESTRICT="test"

RDEPEND=">=dev-python/flask-0.10.1[${PYTHON_USEDEP}]
	dev-python/itsdangerous[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.2[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.2.9[${PYTHON_USEDEP}]
	>=dev-python/flask-mail-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/flask-wtf-0.9.3f[${PYTHON_USEDEP}]
	>=dev-python/flask-principal-0.4.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/flask-sqlalchemy[${PYTHON_USEDEP}]
		dev-python/flask-mongoengine[${PYTHON_USEDEP}]
		dev-python/flask-peewee[${PYTHON_USEDEP}]
		dev-python/bcrypt[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}
