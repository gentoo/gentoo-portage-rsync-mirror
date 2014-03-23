# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/keystone/keystone-2013.1.5.ebuild,v 1.1 2014/03/23 20:03:24 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="The Openstack authentication, authorization, and service catalog written in Python."
HOMEPAGE="https://launchpad.net/keystone"
SRC_URI="http://launchpad.net/${PN}/grizzly/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+sqlite mysql postgres ldap test"
REQUIRED_USE="|| ( mysql postgres sqlite )"

#todo, seperate out rdepend via use flags
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/Babel
			dev-python/decorator
			dev-python/eventlet
			dev-python/greenlet
			dev-python/httplib2
			dev-python/iso8601
			dev-python/lxml
			dev-python/netifaces
			dev-python/nose
			dev-python/nosexcover
			dev-python/passlib
			dev-python/paste
			dev-python/pastedeploy
			dev-python/python-pam
			dev-python/repoze-lru
			dev-python/routes
			dev-python/netaddr
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			<dev-python/sphinx-1.2[${PYTHON_USEDEP}]
			>=dev-python/sqlalchemy-migrate-0.7
			dev-python/tempita
			>=dev-python/webob-1.0.8
			dev-python/webtest
			dev-python/python-memcached
			)"
RDEPEND="dev-python/eventlet[${PYTHON_USEDEP}]
	dev-python/greenlet[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-0.2.1[${PYTHON_USEDEP}]
	<=dev-python/python-keystoneclient-0.3[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-1.1.0[${PYTHON_USEDEP}]
	<dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
	dev-python/passlib[${PYTHON_USEDEP}]
	dev-python/paste[${PYTHON_USEDEP}]
	dev-python/pastedeploy[${PYTHON_USEDEP}]
	dev-python/python-daemon[${PYTHON_USEDEP}]
	>=dev-python/python-pam-0.1.4[${PYTHON_USEDEP}]
	dev-python/routes[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-migrate-0.7.2[${PYTHON_USEDEP}]
	=dev-python/webob-1.2.3-r1[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
	sqlite? ( >=dev-python/sqlalchemy-0.7.8[sqlite,${PYTHON_USEDEP}]
	          <dev-python/sqlalchemy-0.7.10[sqlite,${PYTHON_USEDEP}] )
	mysql? ( >=dev-python/sqlalchemy-0.7.8[mysql,${PYTHON_USEDEP}]
	         <dev-python/sqlalchemy-0.7.10[mysql,${PYTHON_USEDEP}] )
	postgres? ( >=dev-python/sqlalchemy-0.7.8[postgres,${PYTHON_USEDEP}]
	            <dev-python/sqlalchemy-0.7.10[postgres,${PYTHON_USEDEP}] )
	ldap? ( dev-python/python-ldap[${PYTHON_USEDEP}] )"
PATCHES=(
)
python_test() {
	# https://bugs.launchpad.net/keystone/+bug/1241956
	nosetests -e 'test_keystoneclient*' || die "testsuite failed under ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install
	newconfd "${FILESDIR}/keystone.confd" keystone
	newinitd "${FILESDIR}/keystone.initd" keystone

	diropts -m 0750
	keepdir /etc/keystone /var/log/keystone
	insinto /etc/keystone
	doins etc/keystone.conf.sample etc/logging.conf.sample
	doins etc/default_catalog.templates etc/policy.json
}
