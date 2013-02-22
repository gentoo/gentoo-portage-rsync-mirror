# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/celery/celery-3.0.14.ebuild,v 1.1 2013/02/22 08:20:07 patrick Exp $

EAPI="4"

# Not broken but unsupported; dev-python/redis-py doesn't
# support python3 which is a dep in tests. pypy fails just 1 test
PYTHON_TESTS_RESTRICTED_ABIS="3.* 2.7-pypy-*"
PYTHON_DEPEND="*:2.7"
RESTRICT_PYTHON_ABIS="2.[5-6]"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="Celery is an open source asynchronous task queue/job queue based on distributed message passing."
HOMEPAGE="http://celeryproject.org/ http://pypi.python.org/pypi/celery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples sql test"

# jython would need: threadpool, simplejson
# python2.5 would need: ordereddict, test? unittest2
# python2.6 would need: multiprocessing, test? simplejson
RDEPEND=">=dev-python/kombu-2.4.7
	<dev-python/kombu-3.0
	sql? ( dev-python/sqlalchemy )
	dev-python/python-dateutil
	>=dev-python/anyjson-0.3.3
	virtual/pyparsing
	>=dev-python/billiard-2.7.3.17
	dev-python/pytz
	"
DEPEND="${RDEPEND}
	test? (
		dev-python/gevent
		>=dev-python/mock-0.7.0
		virtual/python-unittest2
		dev-python/pyopenssl
		dev-python/nose-cover3
		dev-python/sqlalchemy
		dev-python/pymongo
		dev-python/redis-py
		dev-db/redis
	)
	doc? (
		dev-python/docutils
		dev-python/sphinx
		dev-python/jinja
		dev-python/sphinxcontrib-issuetracker
		dev-python/sqlalchemy
	)
	dev-python/setuptools"

src_test() {
	testing() {
		nosetests --py3where build-${PYTHON_ABI}/lib/${PN}/tests
	}
	python_execute_function testing
}

src_compile() {
	distutils_src_compile
	dodocs() {
		echo "test $PYTHON_ABI"
		if [[ "${PYTHON_ABI}" == "2.7" ]]; then
			mkdir docs/.build || die
			PYTHONPATH="${S}/doc:${S}/build-${PYTHON_ABI}"/lib emake -C docs html
		fi
	}
	use doc && python_execute_function dodocs
}

src_install() {
	distutils_src_install --install-scripts="/usr/bin"

	# Main celeryd init.d and conf.d
	newinitd "${FILESDIR}/celery.initd" celery
	newconfd "${FILESDIR}/celery.confd" celery

	if use examples; then
		insinto usr/share/doc/${P}/
		doins -r examples
	fi
	use doc && dohtml -r docs/.build/html/
}
