# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/glance/glance-2014.1.9999.ebuild,v 1.4 2014/07/26 23:15:35 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit git-2 distutils-r1 user

DESCRIPTION="Provides services for discovering, registering, and retrieving
virtual machine images with Openstack"
HOMEPAGE="https://launchpad.net/glance"
EGIT_REPO_URI="https://github.com/openstack/glance.git"
EGIT_BRANCH="stable/icehouse"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="doc mysql postgres +sqlite +swift test"
REQUIRED_USE="|| ( mysql postgres sqlite )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.6.0[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		test? ( >=dev-python/hacking-0.8.0[${PYTHON_USEDEP}]
				<dev-python/hacking-0.9[${PYTHON_USEDEP}]
				>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
				>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
				>=dev-python/mock-1.0[${PYTHON_USEDEP}]
				>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				<dev-python/sphinx-1.2[${PYTHON_USEDEP}]
				>=dev-python/requests-1.1[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.34[${PYTHON_USEDEP}]
				>=dev-python/psutil-1.1.1[${PYTHON_USEDEP}]
				dev-python/mysql-python[${PYTHON_USEDEP}]
				dev-python/psycopg[${PYTHON_USEDEP}]
				~dev-python/pysendfile-2.0.0[${PYTHON_USEDEP}]
				dev-python/qpid-python[${PYTHON_USEDEP}]
				>=dev-python/pyxattr-0.5.0[${PYTHON_USEDEP}]
				dev-python/oslo-sphinx[${PYTHON_USEDEP}] )"

#note to self, wsgiref is a python builtin, no need to package it
#>=dev-python/wsgiref-0.1.2[${PYTHON_USEDEP}]

RDEPEND=">=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
		sqlite? (
			>=dev-python/sqlalchemy-0.8.0[sqlite,${PYTHON_USEDEP}]
			!~dev-python/sqlalchemy-0.9.5[sqlite,${PYTHON_USEDEP}]
			<=dev-python/sqlalchemy-0.9.99[sqlite,${PYTHON_USEDEP}]
		)
		mysql? (
			dev-python/mysql-python
			>=dev-python/sqlalchemy-0.8.0[${PYTHON_USEDEP}]
			!~dev-python/sqlalchemy-0.9.5[${PYTHON_USEDEP}]
			<=dev-python/sqlalchemy-0.9.99[${PYTHON_USEDEP}]
		)
		postgres? (
		dev-python/psycopg:2
			>=dev-python/sqlalchemy-0.8.0[${PYTHON_USEDEP}]
			!~dev-python/sqlalchemy-0.9.5[${PYTHON_USEDEP}]
			<=dev-python/sqlalchemy-0.9.99[${PYTHON_USEDEP}]
		)
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
		>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
		>=dev-python/boto-2.12.0[${PYTHON_USEDEP}]
		!~dev-python/boto-2.13.0[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-migrate-0.9[${PYTHON_USEDEP}]
		>=dev-python/httplib2-0.7.5[${PYTHON_USEDEP}]
		>=dev-python/kombu-2.4.8[${PYTHON_USEDEP}]
		>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.9[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.1[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.14[${PYTHON_USEDEP}]
		swift? (
			>=dev-python/python-swiftclient-1.6[${PYTHON_USEDEP}]
		)
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-2.0.0[${PYTHON_USEDEP}]
		<dev-python/jsonschema-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.6[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/pyopenssl-0.11[${PYTHON_USEDEP}]
		>=dev-python/six-1.6.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-messaging-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-vmware-0.2[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/${PN}-2013.2-sphinx_mapping.patch )

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
	nosetests glance/ || die "tests failed under python2.7"
}

python_install() {
	distutils-r1_python_install

	for svc in api registry scrubber; do
		newinitd "${FILESDIR}/glance.initd" glance-${svc}
	done

	diropts -m 0750 -o glance -g glance
	dodir /var/log/glance /var/lib/glance/images /var/lib/glance/scrubber
	keepdir /etc/glance
	keepdir /var/log/glance
	keepdir /var/lib/glance/images
	keepdir /var/lib/glance/scrubber

	insinto /etc/glance
	insopts -m 0640 -o glance -g glance
	doins "etc/glance-api-paste.ini"
	doins "etc/glance-api.conf"
	doins "etc/glance-cache.conf"
	doins "etc/glance-registry-paste.ini"
	doins "etc/glance-registry.conf"
	doins "etc/glance-scrubber.conf"
	doins "etc/logging.cnf.sample"
	doins "etc/policy.json"
	doins "etc/schema-image.json"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	distutils-r1_python_install_all
}
