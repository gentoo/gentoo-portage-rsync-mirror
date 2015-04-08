# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/celery/celery-3.1.16.ebuild,v 1.2 2014/12/08 09:02:56 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 bash-completion-r1

DESCRIPTION="Open source asynchronous task queue/job queue based on distributed message passing"
HOMEPAGE="http://celeryproject.org/ http://pypi.python.org/pypi/celery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# There are a number of other optional 'extras' which overlap with those of kombu, however
# there has been no apparent expression of interest or demand by users for them. See requires.txt
IUSE="doc examples redis test"

PY2_USEDEP=$(python_gen_usedep python2_7)
RDEPEND="<dev-python/kombu-3.1[${PYTHON_USEDEP}]
		>=dev-python/kombu-3.0.23[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		>=dev-python/billiard-3.3.0.18[${PYTHON_USEDEP}]
		<dev-python/billiard-3.4[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/greenlet[${PYTHON_USEDEP}]"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		dev-python/gevent[${PY2_USEDEP}]
		>=dev-python/mock-1.0.1[${PY2_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		>=dev-python/pymongo-2.6.2[${PYTHON_USEDEP}]
		redis? ( dev-python/redis-py[${PYTHON_USEDEP}]
			>=dev-db/redis-2.8.0 )
		 >=dev-python/python-dateutil-2.1[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/docutils[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/celery-docs.patch
		"${FILESDIR}"/${PN}-3.1.11-test.patch )

# testsuite needs it own source
DISTUTILS_IN_SOURCE_BUILD=1

python_compile_all() {
	if use doc; then
		mkdir docs/.build || die
		emake -C docs html
	fi
}

python_test() {
	nosetests || die "Tests failed with ${EPYTHON}"
	# alternate method to run testsuite
	# esetup.py
}

python_install_all() {
	# Main celeryd init.d and conf.d
	newinitd "${FILESDIR}/celery.initd-r1" celery
	newconfd "${FILESDIR}/celery.confd-r1" celery

	use examples && local EXAMPLES=( examples/. )

	use doc && local HTML_DOCS=( docs/.build/html/. )

	newbashcomp extra/bash-completion/celery.bash ${PN}

	distutils-r1_python_install_all
}
