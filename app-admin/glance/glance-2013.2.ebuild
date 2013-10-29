# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/glance/glance-2013.2.ebuild,v 1.1 2013/10/29 05:02:54 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Provides services for discovering, registering, and retrieving
virtual machine images with Openstack"
HOMEPAGE="https://launchpad.net/glance"
SRC_URI="http://launchpad.net/${PN}/havana/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres +sqlite +swift"
REQUIRED_USE="|| ( mysql postgres sqlite )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]"
#note to self, wsgiref is a python builtin, no need to package it
#>=dev-python/wsgiref-0.1.2[${PYTHON_USEDEP}]
RDEPEND="${DEPEND}
		>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
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
		>=dev-python/sqlalchemy-migrate-0.7.2[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/kombu-2.4.8[${PYTHON_USEDEP}]
		>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		swift? (
			>=dev-python/python-swiftclient-1.5[${PYTHON_USEDEP}]
			<dev-python/python-swiftclient-2[${PYTHON_USEDEP}]
		)
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-1.3.0[${PYTHON_USEDEP}]
		!~dev-python/jsonschema-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.4[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.0[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]"

PATCHES=(
)

python_install() {
	distutils-r1_python_install
	newconfd "${FILESDIR}/glance.confd" glance
	newinitd "${FILESDIR}/glance-2.initd" glance

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
}
