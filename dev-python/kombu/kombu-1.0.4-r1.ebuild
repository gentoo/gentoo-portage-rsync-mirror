# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kombu/kombu-1.0.4-r1.ebuild,v 1.2 2013/03/26 06:24:38 prometheanfire Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 python3_2 )

inherit distutils-r1

DESCRIPTION="AMQP Messaging Framework for Python"
HOMEPAGE="http://pypi.python.org/pypi/kombu https://github.com/celery/kombu"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/anyjson
	>=dev-python/amqplib-0.6"
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

python_compile() {
	distutils-r1_python_compile

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

python_test() {
	nosetests --py3where build-${PYTHON_ABI}/lib/${PN}/tests || die "nose tests
	failed for ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install
	if use examples; then
		docompress -x usr/share/doc/${P}/examples/
		insinto usr/share/doc/${PF}/
		doins -r examples/
	fi
	use doc && dohtml -r docs/.build/html/
}
