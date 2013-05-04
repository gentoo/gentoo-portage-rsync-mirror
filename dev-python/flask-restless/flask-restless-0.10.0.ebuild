# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-restless/flask-restless-0.10.0.ebuild,v 1.1 2013/05/04 22:51:10 rafaelmartins Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Flask extension for easy ReSTful API generation"
HOMEPAGE="http://packages.python.org/Flask-Restless/"
SRC_URI="https://github.com/jfinkels/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( AGPL-3 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Can't build docs for now, missing deps
#IUSE="doc"
IUSE=""

RDEPEND=">=dev-python/flask-0.7
	dev-python/flask-sqlalchemy
	dev-python/sqlalchemy
	dev-python/python-dateutil"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/unittest2 )"

PYTHON_MODNAME="flask_restless"
