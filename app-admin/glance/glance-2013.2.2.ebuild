# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/glance/glance-2013.2.2.ebuild,v 1.1 2014/02/20 21:00:22 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 user

DESCRIPTION="Provides services for discovering, registering, and retrieving
virtual machine images with Openstack"
HOMEPAGE="https://launchpad.net/glance"
SRC_URI="http://launchpad.net/${PN}/havana/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc mysql postgres +sqlite +swift test"
REQUIRED_USE="|| ( mysql postgres sqlite )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/pbr[${PYTHON_USEDEP}]
		test? ( >=dev-python/coverage-3.6[${PYTHON_USEDEP}]
			>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/nose-exclude[${PYTHON_USEDEP}]
			>=dev-python/openstack-nose-plugin-0.7[${PYTHON_USEDEP}]
			>=dev-python/mock-1.0[${PYTHON_USEDEP}]
			>=dev-python/nosehtmloutput-0.0.3[${PYTHON_USEDEP}]
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			>=dev-python/requests-1.1[${PYTHON_USEDEP}]
			>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
			>=dev-python/psutil-0.6.1[${PYTHON_USEDEP}]
			dev-python/mysql-python[${PYTHON_USEDEP}]
			dev-python/psycopg[${PYTHON_USEDEP}]
			>=dev-python/pyxattr-0.5.0[${PYTHON_USEDEP}]
			~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
			>=dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
			<dev-python/pyflakes-0.7.4[${PYTHON_USEDEP}]
			~dev-python/flake8-2.0[${PYTHON_USEDEP}]
			>=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
			<dev-python/hacking-0.8[${PYTHON_USEDEP}]
			>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
			=dev-python/pysendfile-2.0.0[${PYTHON_USEDEP}]
			dev-python/qpid-python[${PYTHON_USEDEP}]
			dev-python/oslo-sphinx
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			<dev-python/sphinx-1.2[${PYTHON_USEDEP}] )"
#note to self, wsgiref is a python builtin, no need to package it
#>=dev-python/wsgiref-0.1.2[${PYTHON_USEDEP}]

RDEPEND=">=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
		sqlite? ( >=dev-python/sqlalchemy-0.7.8[sqlite,${PYTHON_USEDEP}]
				  <dev-python/sqlalchemy-0.7.99[sqlite,${PYTHON_USEDEP}] )
		mysql? ( >=dev-python/sqlalchemy-0.7.8[mysql,${PYTHON_USEDEP}]
				 <dev-python/sqlalchemy-0.7.99[mysql,${PYTHON_USEDEP}] )
		postgres? ( >=dev-python/sqlalchemy-0.7.8[postgres,${PYTHON_USEDEP}]
					<dev-python/sqlalchemy-0.7.99[postgres,${PYTHON_USEDEP}] )
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
		>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
		<dev-python/webob-1.3[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/boto-2.4.0[${PYTHON_USEDEP}]
		!~dev-python/boto-2.13.0[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-migrate-0.7.2[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/kombu-2.4.8[${PYTHON_USEDEP}]
		>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.8[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.1[${PYTHON_USEDEP}]
		swift? (
			>=dev-python/python-swiftclient-1.5[${PYTHON_USEDEP}]
			<dev-python/python-swiftclient-2[${PYTHON_USEDEP}]
		)
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-1.3.0[${PYTHON_USEDEP}]
		!~dev-python/jsonschema-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.6[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.2[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		>=dev-python/six-1.4.1[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}-2013.2-sphinx_mapping.patch" )

pkg_setup() {
	enewgroup glance
	enewuser glance -1 -1 /var/lib/glance glance
}

python_compile_all() {
	use doc && "${PYTHON}" setup.py build_sphinx
}

python_test() {
	# https://bugs.launchpad.net/glance/+bug/1251105
	# https://bugs.launchpad.net/glance/+bug/1242501
	# 2013.2 requires =dev-python/iso8601-0.1.4
	nosetests glance/ || die "tests failed under python2.7"
}

python_install() {
	distutils-r1_python_install
	newconfd "${FILESDIR}/glance.confd" glance
	newinitd "${FILESDIR}/glance.initd" glance

	for function in api registry scrubber; do
		dosym /etc/init.d/glance /etc/init.d/glance-${function}
	done

	diropts -m 0750
	dodir /var/run/glance /var/log/glance /var/lib/glance/images /var/lib/glance/scrubber
	keepdir /etc/glance
	keepdir /var/log/glance
	keepdir /var/lib/glance/images
	keepdir /var/lib/glance/scrubber
	insinto /etc/glance

	doins "etc/glance-api-paste.ini"
	doins "etc/glance-api.conf"
	doins "etc/glance-cache.conf"
	doins "etc/glance-registry-paste.ini"
	doins "etc/glance-registry.conf"
	doins "etc/glance-scrubber.conf"
	doins "etc/logging.cnf.sample"
	doins "etc/policy.json"
	doins "etc/schema-image.json"

	fowners glance:glance /var/run/glance /var/log/glance /var/lib/glance/images /var/lib/glance/scrubber /etc/glance
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	distutils-r1_python_install_all
}
