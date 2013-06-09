# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-openid/flask-openid-1.1.1-r1.ebuild,v 1.1 2013/06/09 17:15:25 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

MY_PN="Flask-OpenID"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="OpenID support for Flask"
HOMEPAGE="http://pypi.python.org/pypi/Flask-OpenID"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=dev-python/flask-0.3[${PYTHON_USEDEP}]
	>=dev-python/python-openid-2.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	use examples && local EXAMPLES=( example/. )
	distutils-r1_python_install_all
}
