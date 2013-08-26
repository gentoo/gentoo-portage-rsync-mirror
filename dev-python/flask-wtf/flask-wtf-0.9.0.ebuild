# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-wtf/flask-wtf-0.9.0.ebuild,v 1.1 2013/08/26 02:11:16 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN="Flask-WTF"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple integration of Flask and WTForms, including CSRF, file upload and Recaptcha integration."
HOMEPAGE="http://pythonhosted.org/Flask-WTF/ https://pypi.python.org/pypi/Flask-WTF"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	>=dev-python/wtforms-1.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/flask-testing[${PYTHON_USEDEP}]
		dev-python/flask-uploads[${PYTHON_USEDEP}]
		dev-python/speaklater[${PYTHON_USEDEP}]
		dev-python/flask-babel[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}
