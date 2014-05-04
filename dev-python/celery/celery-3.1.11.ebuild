# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/celery/celery-3.1.11.ebuild,v 1.1 2014/05/04 10:18:35 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Celery is an open source asynchronous task queue/job queue based on distributed message passing."
HOMEPAGE="http://celeryproject.org/ http://pypi.python.org/pypi/celery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples redis test"

PY2_USEDEP=$(python_gen_usedep python2_7)
RDEPEND="<dev-python/kombu-4
		>=dev-python/kombu-3.0.15[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-1.5[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		>=dev-python/billiard-3.3.0.17[${PYTHON_USEDEP}]
		<dev-python/billiard-3.4[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/gevent[${PY2_USEDEP}]
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		virtual/python-unittest2[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		redis? ( dev-python/redis-py[${PYTHON_USEDEP}]
			>=dev-db/redis-2.8.0 )
	)
	doc? (
		dev-python/docutils[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/celery-docs.patch
		"${FILESDIR}"/${P}-test.patch )

python_compile_all() {
	if use doc; then
		mkdir docs/.build || die
		emake -C docs html
	fi
}

python_test() {
	# https://github.com/celery/celery/issues/1964
#	nosetests -e test_cleanup || die "Tests failed with ${EPYTHON}"
	nosetests || die "Tests failed with ${EPYTHON}"
}

python_install_all() {
	# Main celeryd init.d and conf.d
	newinitd "${FILESDIR}/celery.initd-r1" celery
	newconfd "${FILESDIR}/celery.confd-r1" celery

	use examples && local EXAMPLES=( examples/. )

	use doc && local HTML_DOCS=( docs/.build/html/. )

	distutils-r1_python_install_all
}
