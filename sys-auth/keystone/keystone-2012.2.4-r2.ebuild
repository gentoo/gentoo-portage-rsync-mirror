# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/keystone/keystone-2012.2.4-r2.ebuild,v 1.1 2013/05/10 16:14:06 prometheanfire Exp $

EAPI=5
#test restricted becaues of bad requirements given (old webob for instance)
RESTRICT="test"
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="Keystone is the Openstack authentication, authorization, and
service catalog written in Python."
HOMEPAGE="https://launchpad.net/keystone"
SRC_URI="http://launchpad.net/${PN}/folsom/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="folsom"
KEYWORDS="~amd64 ~x86"
IUSE="+sqlite mysql postgres ldap"
#IUSE="+sqlite mysql postgres ldap test"
REQUIRED_USE="|| ( ldap mysql postgres sqlite )"

#todo, seperate out rdepend via use flags
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/eventlet
	dev-python/greenlet
	dev-python/iso8601[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/passlib
	dev-python/paste
	dev-python/pastedeploy
	dev-python/python-daemon
	dev-python/python-pam[${PYTHON_USEDEP}]
	dev-python/routes
	>=dev-python/sqlalchemy-migrate-0.7
	>=dev-python/webob-1.0.8
	virtual/python-argparse[${PYTHON_USEDEP}]
	sqlite? ( dev-python/sqlalchemy[sqlite] )
	mysql? ( dev-python/sqlalchemy[mysql] )
	postgres? ( dev-python/sqlalchemy[postgres] )
	ldap? ( dev-python/python-ldap )"
#	test? ( dev-python/Babel
#			dev-python/decorator
#			dev-python/eventlet
#			dev-python/greenlet
#			dev-python/httplib2
#			dev-python/iso8601
#			dev-python/lxml
#			dev-python/netifaces
#			dev-python/nose
#			dev-python/nosexcover
#			dev-python/passlib
#			dev-python/paste
#			dev-python/pastedeploy
#			dev-python/python-pam
#			dev-python/repoze-lru
#			dev-python/routes
#			dev-python/sphinx
#			>=dev-python/sqlalchemy-migrate-0.7
#			dev-python/tempita
#			>=dev-python/webob-1.0.8
#			dev-python/webtest
#			)
#PATCHES=( "${FILESDIR}"/keystone_test-requires.patch )
#
#python_test() {
#	"${PYTHON}" setup.py nosetests || die
#}

PATCHES=(
	"${FILESDIR}/keystone-folsom-4-CVE-2013-2030.patch"
	"${FILESDIR}/keystone-folsom-4-CVE-2013-2059.patch"
)

python_install() {
	distutils-r1_python_install
	newconfd "${FILESDIR}/keystone.confd" keystone
	newinitd "${FILESDIR}/keystone.initd" keystone

	diropts -m 0750
	dodir /var/run/keystone /var/log/keystone /etc/keystone
	keepdir /etc/keystone
	insinto /etc/keystone
	doins etc/keystone.conf.sample etc/logging.conf.sample
	doins etc/default_catalog.templates etc/policy.json
}
