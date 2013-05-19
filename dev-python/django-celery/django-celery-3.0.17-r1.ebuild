# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-celery/django-celery-3.0.17-r1.ebuild,v 1.1 2013/05/19 10:25:24 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Celery Integration for Django"
HOMEPAGE="http://celeryproject.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/celery-3.0.17[${PYTHON_USEDEP}]
	>=dev-python/django-1.3[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		virtual/python-unittest2[${PYTHON_USEDEP}]
		dev-python/django-nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/python-memcached )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinxcontrib-issuetracker[${PYTHON_USEDEP}]
		dev-python/python-memcached
	)"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	# https://github.com/celery/django-celery/issues/249
	python tests/manage.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/.build/html/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
