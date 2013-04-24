# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kombu/kombu-2.5.10.ebuild,v 1.1 2013/04/24 06:54:40 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_1,3_2} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="AMQP Messaging Framework for Python"
HOMEPAGE="http://pypi.python.org/pypi/kombu https://github.com/celery/kombu"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amqplib doc examples test"

RDEPEND=">=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
	amqplib? ( >=dev-python/amqplib-1.0.2[${PYTHON_USEDEP}] )
	>=dev-python/py-amqp-1.0.6[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose-cover3[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/simplejson[$(python_gen_usedep python2_7),$(python_gen_usedep pypy{1_9,2_0})]
	dev-python/anyjson[${PYTHON_USEDEP}]
	dev-python/redis-py[${PYTHON_USEDEP}]
	dev-python/pymongo[$(python_gen_usedep python2_7),$(python_gen_usedep pypy{1_9,2_0})]
	dev-python/msgpack[$(python_gen_usedep python2_7),$(python_gen_usedep python{3_1,3_2})] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/django[$(python_gen_usedep python{2_7,3_2})]
	dev-python/beanstalkc[$(python_gen_usedep python2_7)]
	dev-python/couchdb-python[$(python_gen_usedep python2_7)] )
	dev-python/setuptools[${PYTHON_USEDEP}]"
RESTRICT="test"

python_compile() {
	local SPHINXBUILD
	# This will force sphinx-build to use python2.7
	if use doc; then
		if [[ "${EPYTHON}" == 'python2.7' ]]; then
			local EPYTHON="python2.7"
			export EPYTHON
			einfo "building docs for kombu with python2.7"
			PYTHONPATH="${S}" emake -C docs html || die "kombu docs failed installation"
		fi
	fi
	distutils-r1_python_compile
}

python_test() {
# wip; https://github.com/celery/kombu/issues/227
#	if [[ "${EPYTHON}" != python3* ]]; then
		nosetests -e 'test_basic_consume_registers_ack_status*' -e 'test_close_resolves_connection_cycle*' \
			-e 'test_init*' -e 'test_message_to_python*' -e 'test_prepare_message*' \
			|| die "Tests failed under ${EPYTHON}"
#	fi
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		docompress -x usr/share/doc/${P}/examples/
		insinto usr/share/doc/${PF}/
		doins -r examples/
	fi
	use doc && dohtml -r docs/.build/html/
}
