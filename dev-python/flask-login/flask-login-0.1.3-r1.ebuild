# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-login/flask-login-0.1.3-r1.ebuild,v 1.1 2013/06/09 16:36:06 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="Flask-Login"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Login session support for Flask"
HOMEPAGE="http://pypi.python.org/pypi/Flask-Login"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/flask-0.3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
