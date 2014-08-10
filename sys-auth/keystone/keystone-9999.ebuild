# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/keystone/keystone-9999.ebuild,v 1.19 2014/08/10 20:21:57 slyfox Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-2 distutils-r1 user

DESCRIPTION="The Openstack authentication, authorization, and service catalog written in Python"
HOMEPAGE="https://launchpad.net/keystone"
EGIT_REPO_URI="https://github.com/openstack/keystone.git"
EGIT_BRANCH="master"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
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
			dev-python/sphinx
			>=dev-python/sqlalchemy-migrate-0.7
			dev-python/tempita
			>=dev-python/webob-1.0.8
			dev-python/webtest
			dev-python/python-memcached )
	>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
	<dev-python/pbr-1.0[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/python-pam-0.1.4[${PYTHON_USEDEP}]
	>=dev-python/webob-1.2.3-r1[${PYTHON_USEDEP}]
	<dev-python/webob-1.3[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
	dev-python/paste[${PYTHON_USEDEP}]
	>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
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
	>=dev-python/sqlalchemy-migrate-0.7.2[${PYTHON_USEDEP}]
	dev-python/passlib[${PYTHON_USEDEP}]
	>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/Babel-0.9.6[${PYTHON_USEDEP}]
	dev-python/oauth2[${PYTHON_USEDEP}]
	>=dev-python/dogpile-cache-0.5.0[${PYTHON_USEDEP}]
	dev-python/python-daemon[${PYTHON_USEDEP}]
	ldap? ( dev-python/python-ldap[${PYTHON_USEDEP}] )
	>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
	<dev-python/pbr-1.0[${PYTHON_USEDEP}]"

PATCHES=(
)

pkg_setup() {
	enewgroup keystone
	enewuser keystone -1 -1 /var/lib/keystone keystone
}

python_prepare_all() {
	cp etc/keystone-paste.ini ${PN}/tests/tmp/ || die
	distutils-r1_python_prepare_all
}

# Ignore (naughty) test_.py files & 1 test that connect to the network
#-I 'test_keystoneclient*' \
python_test() {
	nosetests -I 'test_keystoneclient*' \
		-e test_static_translated_string_is_Message \
		-e test_get_token_id_error_handling \
		-e test_provider_token_expiration_validation \
		-e test_import --process-restartworker --process-timeout=60 || die "testsuite failed under python2.7"
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
	doins etc/policy.v3cloudsample.json etc/keystone-paste.ini

	fowners keystone:keystone /etc/keystone /var/log/keystone
}

pkg_postinst() {
	elog "You might want to run:"
	elog "emerge --config =${CATEGORY}/${PF}"
	elog "if this is a new install."
	elog "If you have not already configured your openssl installation"
	elog "please do it by modifying /etc/ssl/openssl.cnf"
	elog "BEFORE issuing the configuration command."
	elog "Otherwise default values will be used."
}

pkg_config() {
	if [ ! -d "${ROOT}"/etc/keystone/ssl ] ; then
		einfo "Press ENTER to configure the keystone PKI, or Control-C to abort now..."
		read
		"${ROOT}"/usr/bin/keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
	else
		einfo "keystone PKI certificates directory already present, skipping configuration"
	fi
}
