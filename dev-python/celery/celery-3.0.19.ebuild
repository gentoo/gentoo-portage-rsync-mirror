# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/celery/celery-3.0.19.ebuild,v 1.5 2013/05/10 03:50:44 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Celery is an open source asynchronous task queue/job queue based on distributed message passing."
HOMEPAGE="http://celeryproject.org/ http://pypi.python.org/pypi/celery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

PY2_USEDEP=$(python_gen_usedep python2_7)

RDEPEND="<dev-python/kombu-3
		>=dev-python/kombu-2.5.10[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-1.5[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		virtual/pyparsing[${PYTHON_USEDEP}]
		>=dev-python/billiard-2.7.3.28[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/gevent[${PY2_USEDEP}]
		>=dev-python/mock-0.7.0[${PYTHON_USEDEP}]
		virtual/python-unittest2[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/redis-py[${PYTHON_USEDEP}]
		dev-db/redis
	)
	doc? (
		dev-python/docutils[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/sphinxcontrib-issuetracker[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)"

PATCHES=( "${FILESDIR}"/celery-docs.patch )

python_compile_all() {
	if use doc; then
		mkdir docs/.build || die
		emake -C docs html
	fi
}

python_test() {
	if [[ "$EPYTHON}" = python3* ]]; then
		ewarn "dep gevent of testsuite doesn't support python3"
		ewarn "testsuite also needs re-writing for py3 despite citing py3k"
	else
		nosetests || die "Tests failed with ${EPYTHON}"
		# These have some failures, filed upstream
		#einfo "running funtests"
		#"${PYTHON}" funtests/setup.py test || die "Failure occured in funtests"
	fi
}

python_install_all() {
	# Main celeryd init.d and conf.d
	newinitd "${FILESDIR}/celery.initd" celery
	newconfd "${FILESDIR}/celery.confd" celery

	use examples && local EXAMPLES=( examples/. )

	use doc && local HTML_DOCS=( docs/.build/html/. )

	distutils-r1_python_install_all
}
