# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-sqlalchemy/flask-sqlalchemy-0.16.ebuild,v 1.1 2012/11/15 14:23:34 idella4 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Flask-SQLAlchemy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SQLAlchemy support for Flask applications"
HOMEPAGE="http://pypi.python.org/pypi/Flask-SQLAlchemy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/flask
	dev-python/setuptools
	dev-python/sqlalchemy"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="flask_sqlalchemy.py"

src_prepare() {
	sed -ie "s/flaskext/flask.ext/" test.py || die
}
