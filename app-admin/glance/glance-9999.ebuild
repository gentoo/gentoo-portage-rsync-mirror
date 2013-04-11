# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/glance/glance-9999.ebuild,v 1.3 2013/04/11 07:25:24 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit git-2 distutils-r1

DESCRIPTION="Provides services for discovering, registering, and retrieving
virtual machine images with Openstack"
HOMEPAGE="https://launchpad.net/glance"
EGIT_REPO_URI="https://github.com/openstack/glance.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="ldap mysql postgres +sqlite +swift"
REQUIRED_USE="|| ( ldap mysql postgres sqlite )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/boto
	dev-python/anyjson[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.9.12[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.3.1[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/iso8601[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/kombu[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-1.1.0[${PYTHON_USEDEP}]
	dev-python/passlib[${PYTHON_USEDEP}]
	dev-python/paste[${PYTHON_USEDEP}]
	dev-python/pastedeploy[${PYTHON_USEDEP}]
	dev-python/pycrypto
	>=dev-python/python-keystoneclient-0.2.0[${PYTHON_USEDEP}]
	dev-python/python-glanceclient[${PYTHON_USEDEP}]
	dev-python/routes[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-migrate-0.7
	>=dev-python/webob-1.2[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
	swift? (
		>=dev-python/python-swiftclient-1.2[${PYTHON_USEDEP}]
		<dev-python/python-swiftclient-2[${PYTHON_USEDEP}]
	)
	sqlite? ( >=dev-python/sqlalchemy-0.7[sqlite]
	          <=dev-python/sqlalchemy-0.7.9[sqlite] )
	mysql? ( >=dev-python/sqlalchemy-0.7[mysql]
	         <=dev-python/sqlalchemy-0.7.9[mysql] )
	postgres? ( >=dev-python/sqlalchemy-0.7[postgres]
	            <=dev-python/sqlalchemy-0.7.9[postgres] )
	ldap? ( dev-python/python-ldap )"

python_install() {
	distutils-r1_python_install
	newconfd "${FILESDIR}/glance.confd" glance
	newinitd "${FILESDIR}/glance.initd" glance

	for function in api registry scrubber; do
		dosym /etc/init.d/glance /etc/init.d/glance-${function}
	done

	diropts -m 0750
	dodir /var/run/glance /var/log/nova /var/lock/nova
	#removed because it conflicts with glanceclient, which we install in rdepend
	rm ${D}"/usr/bin/glance" ${D}"/usr/bin/glance-python2.7"
}
