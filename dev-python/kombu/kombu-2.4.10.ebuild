# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kombu/kombu-2.4.10.ebuild,v 1.4 2013/01/06 19:40:16 mgorny Exp $

EAPI="4"

PYTHON_TESTS_RESTRICTED_ABIS="3.* 2.7-pypy-*"
PYTHON_DEPEND="*:2.7"
RESTRICT_PYTHON_ABIS="2.[56]"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="AMQP Messaging Framework for Python"
HOMEPAGE="http://pypi.python.org/pypi/kombu https://github.com/celery/kombu"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/anyjson-0.3.3
	>=dev-python/amqplib-1.0.2"
DEPEND="${RDEPEND}
	test? ( dev-python/nose-cover3
	dev-python/mock
	virtual/python-unittest2
	dev-python/simplejson
	dev-python/anyjson
	dev-python/redis-py
	dev-python/pymongo
	dev-python/msgpack )
	doc? ( dev-python/sphinx
	dev-python/django
	dev-python/beanstalkc
	dev-python/couchdb-python )
	dev-python/setuptools"

src_compile() {
	distutils_src_compile

	local SPHINXBUILD
	if use doc; then
		if python2.7 -c "import django.conf" &> /dev/null; then
			SPHINXBUILD="sphinx-build-2.7"
		else
			die "kombu docs failed installation"
		fi
		einfo "building docs for kombu with python2.7"
		PYTHONPATH="${S}" emake -C docs html SPHINXBUILD="${SPHINXBUILD}"
	fi
}

src_test() {
	testing() {
		nosetests --py3where build-${PYTHON_ABI}/lib/${PN}/tests
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use examples; then
		docompress -x usr/share/doc/${P}/examples/
		insinto usr/share/doc/${PF}/
		doins -r examples/
	fi
	use doc && dohtml -r docs/.build/html/
}
