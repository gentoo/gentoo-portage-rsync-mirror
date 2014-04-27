# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kombu/kombu-3.0.15.ebuild,v 1.1 2014/04/27 08:15:45 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="AMQP Messaging Framework for Python"
HOMEPAGE="http://pypi.python.org/pypi/kombu https://github.com/celery/kombu"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amqplib doc examples msgpack sqs test"

PY27_GEN_USEDEP=$(python_gen_usedep python2_7)
RDEPEND=">=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		>=dev-python/py-amqp-1.4.5[${PYTHON_USEDEP}]
		<dev-python/py-amqp-2.0[${PYTHON_USEDEP}]
		amqplib? ( >=dev-python/amqplib-1.0.2[${PYTHON_USEDEP}] )
		sqs? ( >=dev-python/boto-2.13.3[${PY27_GEN_USEDEP}] )
		msgpack? ( >=dev-python/msgpack-0.2.0[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.7[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		>=dev-python/mock-0.7[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/redis-py[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		>=dev-python/unittest2-0.5.0[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/beanstalkc[${PY27_GEN_USEDEP}]
		dev-python/couchdb-python[${PY27_GEN_USEDEP}]
		>=dev-python/sphinxcontrib-issuetracker-0.9[${PYTHON_USEDEP}] )"
# pyyaml is an optional package for tests, refrain for now
# Req'd for test phase
DISTUTILS_IN_SOURCE_BUILD=1

PY27_REQUSE="$(python_gen_useflags 'python2.7')"
REQUIRED_USE="sqs? ( ${PY27_REQUSE} )
		doc? ( ${PY27_REQUSE} amqplib sqs )"	# 2 deps in doc build are only py2 capable

python_prepare_all() {
	https://github.com/celery/kombu/issues/246
	sed -e 's:kombu.transports:kombu.transport:' -i funtests/tests/test_django.py
	distutils-r1_python_prepare_all
}

python_compile_all() {
	# Doc build must be done by py2.7
	# Doc build misses and skips only content re librabbitmq which is not in portage
	if use doc; then
		emake -C docs html || die "kombu docs failed installation"
	fi
}

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	if python_is_python3; then
		2to3 --no-diffs -w build/lib/kombu/transport/
		nosetests --py3where=build/lib kombu/tests || die "Tests failed under ${EPYTHON}"
	else
		# funtests appears to be coded only for py2, a kind of 2nd tier.
		nosetests "${S}"/kombu/tests || die "Tests failed under ${EPYTHON}"
		# https://github.com/celery/kombu/issues/346
		pushd funtests > /dev/null
		# Disable test_redis.py for now
		mv tests/test_redis.py tests/tredis.py || die
		esetup.py test
		popd > /dev/null
	fi
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	use doc && local HTML_DOCS=( docs/.build/html/. )
	distutils-r1_python_install_all
}
