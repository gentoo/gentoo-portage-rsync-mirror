# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-celery/django-celery-3.1.9.ebuild,v 1.3 2014/07/06 12:41:16 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Celery Integration for Django"
HOMEPAGE="http://celeryproject.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

PY2_USEDEP=$(python_gen_usedep python2_7)
RDEPEND=">=dev-python/celery-3.1.9[${PYTHON_USEDEP}]
	>=dev-python/django-1.3[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/django-nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/python-memcached[${PY2_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinxcontrib-issuetracker[${PY2_USEDEP}]
		dev-python/python-memcached[${PY2_USEDEP}]
	)"

PY27_REQUSE="$(python_gen_useflags 'python2.7')"
REQUIRED_USE="
	doc? ( ${PY27_REQUSE} )"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	# py3 has masses of errors
	# https://github.com/celery/django-celery/issues/321
	if ! python_is_python3; then
		sed -e s':test_forget:_&:' -i djcelery/tests/test_backends/test_database.py || die
		"${PYTHON}" tests/manage.py test
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/.build/html/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
