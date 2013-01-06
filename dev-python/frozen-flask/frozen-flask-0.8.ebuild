# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/frozen-flask/frozen-flask-0.8.ebuild,v 1.1 2012/03/09 08:20:28 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Frozen-Flask"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Freezes a Flask application into a set of static files."
HOMEPAGE="https://github.com/SimonSapin/Frozen-Flask http://pypi.python.org/pypi/Frozen-Flask"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/flask-0.7"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="flask_frozen"
