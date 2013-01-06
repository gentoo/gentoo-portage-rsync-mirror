# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-evolution/flask-evolution-0.5.ebuild,v 1.1 2012/06/10 02:11:12 rafaelmartins Exp $

EAPI=4
PYTHON_COMPAT="python2_5 python2_6 python2_7"

inherit python-distutils-ng

MY_PN="Flask-Evolution"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple migrations for Flask/SQLAlchemy projects"
HOMEPAGE="http://pypi.python.org/pypi/Flask-Evolution"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
	dev-python/flask
	dev-python/flask-sqlalchemy
	dev-python/flask-script"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
