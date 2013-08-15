# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kombu/kombu-2.5.10.ebuild,v 1.4 2013/08/15 03:47:53 patrick Exp $

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
		>=dev-python/py-amqp-1.0.12[${PYTHON_USEDEP}]
		amqplib? ( >=dev-python/amqplib-1.0.2[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	test? ( dev-python/nose-cover3[${PYTHON_USEDEP}]
		>=dev-python/mock-0.7[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		dev-python/redis-py[${PYTHON_USEDEP}]
		dev-python/pymongo[$(python_gen_usedep python2_7)]
		dev-python/msgpack[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/beanstalkc[$(python_gen_usedep python2_7)]
		dev-python/couchdb-python[$(python_gen_usedep python2_7)] )
	dev-python/setuptools[${PYTHON_USEDEP}]"
DISTUTILS_IN_SOURCE_BUILD=1

PATCHES=( "${FILESDIR}"/${P}-tests.patch )

python_compile_all() {
	if use doc; then
		emake -C docs html || die "kombu docs failed installation"
	fi
}

# https://github.com/celery/kombu/issues/227
python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	if [[ "${EPYTHON}" == python3* ]]; then
		nosetests --py3where=build/lib \
		-e test_produce_consume -e test_produce_consume_noack kombu/tests \
		|| die "Tests failed under ${EPYTHON}"
	else
		nosetests || die "Tests failed under ${EPYTHON}"
	fi
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	use doc && local HTML_DOCS=( docs/.build/html/. )
	distutils-r1_python_install_all
}
