# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kombu/kombu-2.5.14.ebuild,v 1.1 2013/09/02 08:01:45 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="AMQP Messaging Framework for Python"
HOMEPAGE="http://pypi.python.org/pypi/kombu https://github.com/celery/kombu"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amqplib doc examples test"

RDEPEND=">=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		=dev-python/py-amqp-1.0.12[${PYTHON_USEDEP}]
		amqplib? ( >=dev-python/amqplib-1.0.2[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		>=dev-python/mock-0.7[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/redis-py[${PYTHON_USEDEP}]
		dev-python/pymongo[$(python_gen_usedep python2_7)]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/unittest2[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/beanstalkc[$(python_gen_usedep python2_7)]
		dev-python/couchdb-python[$(python_gen_usedep python2_7)]
		>=dev-python/sphinxcontrib-issuetracker-0.9[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"
# Req'd for tests
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	https://github.com/celery/kombu/issues/246
	sed -e 's:kombu.transports:kombu.transport:' -i funtests/tests/test_django.py
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		emake -C docs html || die "kombu docs failed installation"
	fi
}

python_test() {
	# https://github.com/celery/kombu/issues/246; 'test_serialization.py' errors only in py3.2
	export DJANGO_SETTINGS_MODULE="django.conf"
	if [[ "${EPYTHON}" == python3* ]]; then
		nosetests --py3where=build/lib \
		-e test_produce_consume -e test_produce_consume_noack -e test_msgpack_decode kombu/tests \
		|| die "Tests failed under ${EPYTHON}"
	else
		# funtests appears to be coded only for py2, a kind of 2nd tier.
		nosetests "${S}"/kombu/tests -e test_msgpack_decode || die "Tests failed under ${EPYTHON}"
		nosetests funtests || die "Tests failed under ${EPYTHON}"
	fi
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	use doc && local HTML_DOCS=( docs/.build/html/. )
	distutils-r1_python_install_all
}
