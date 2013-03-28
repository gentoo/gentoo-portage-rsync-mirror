# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-uploads/flask-uploads-0.1.3.ebuild,v 1.1 2013/03/28 04:33:35 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Flexible and efficient upload handling for Flask"
HOMEPAGE="http://pythonhosted.org/Flask-Testing/
	https://pypi.python.org/pypi/Flask-Testing/"
MY_PN="Flask-Uploads"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}
