# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-sqlalchemy/flask-sqlalchemy-1.0.ebuild,v 1.2 2014/05/30 07:31:17 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN="Flask-SQLAlchemy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SQLAlchemy support for Flask applications"
HOMEPAGE="http://pypi.python.org/pypi/Flask-SQLAlchemy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

python_test() {
	#https://github.com/mitsuhiko/flask-sqlalchemy/issues/128
	nosetests || die "Tests failed under ${EPYTHON}"
}
