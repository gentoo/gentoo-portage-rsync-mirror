# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cinder/cinder-2014.2.9999.ebuild,v 1.5 2015/04/02 18:57:23 mr_bones_ Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils git-2 linux-info user

DESCRIPTION="Cinder is the OpenStack Block storage service, a spin out of nova-volumes"
HOMEPAGE="https://launchpad.net/cinder"
EGIT_REPO_URI="https://github.com/openstack/cinder.git"
EGIT_BRANCH="stable/juno"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+api +scheduler +volume iscsi lvm mysql postgres sqlite test"
REQUIRED_USE="|| ( mysql postgres sqlite )"

#sudo is a build dep because I want the sudoers.d directory to exist, lazy.
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.8[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		app-admin/sudo
		test? (
			${RDEPEND}
			>=dev-python/hacking-0.9.2[${PYTHON_USEDEP}]
			<dev-python/hacking-0.10[${PYTHON_USEDEP}]
			>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
			>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
			>=dev-python/mock-1.0[${PYTHON_USEDEP}]
			>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
			mysql? ( dev-python/mysql-python[${PYTHON_USEDEP}] )
			postgres? ( dev-python/psycopg[${PYTHON_USEDEP}] )
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			!~dev-python/sphinx-1.2.0[${PYTHON_USEDEP}]
			<dev-python/sphinx-1.3[${PYTHON_USEDEP}]
			>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
			>=dev-python/testtools-0.9.34[${PYTHON_USEDEP}]
			!~dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
			>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
			>=dev-python/oslo-sphinx-2.2.0[${PYTHON_USEDEP}]
		)"

RDEPEND="
	>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.15.1[${PYTHON_USEDEP}]
	<dev-python/eventlet-0.16.0[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/kombu-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.12[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-1.0.0[${PYTHON_USEDEP}]
	<dev-python/oslo-db-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-1.4.0[${PYTHON_USEDEP}]
	!~dev-python/oslo-messaging-1.5.0[${PYTHON_USEDEP}]
	<dev-python/oslo-messaging-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-rootwrap-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/paramiko-1.13.0[${PYTHON_USEDEP}]
	dev-python/paste[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/python-barbicanclient-2.1.0[${PYTHON_USEDEP}]
	!~dev-python/python-barbicanclient-3.0.0[${PYTHON_USEDEP}]
	<dev-python/python-barbicanclient-3.0.2[${PYTHON_USEDEP}]
	>=dev-python/python-glanceclient-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/python-novaclient-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/python-swiftclient-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-1.2.1[${PYTHON_USEDEP}]
	!~dev-python/requests-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
	!~dev-python/routes-2.0[${PYTHON_USEDEP}]
	>=dev-python/taskflow-0.4[${PYTHON_USEDEP}]
	<dev-python/taskflow-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/rtslib-fb-2.1.39[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.0[${PYTHON_USEDEP}]
	sqlite? (
		>=dev-python/sqlalchemy-0.9.7[sqlite,${PYTHON_USEDEP}]
		<=dev-python/sqlalchemy-0.9.99[sqlite,${PYTHON_USEDEP}]
	)
	mysql? (
		dev-python/mysql-python
		>=dev-python/sqlalchemy-0.9.7[${PYTHON_USEDEP}]
		<=dev-python/sqlalchemy-0.9.99[${PYTHON_USEDEP}]
	)
	postgres? (
		dev-python/psycopg:2
		>=dev-python/sqlalchemy-0.9.7[${PYTHON_USEDEP}]
		<=dev-python/sqlalchemy-0.9.99[${PYTHON_USEDEP}]
	)
	~dev-python/sqlalchemy-migrate-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/suds-0.4[${PYTHON_USEDEP}]
	>=dev-python/webob-1.2.3-r1[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-1.0.0[${PYTHON_USEDEP}]
	iscsi? (
		|| ( >=sys-block/iscsitarget-1.4.20.2_p20130821 sys-block/tgt )
		sys-block/open-iscsi )
	lvm? ( sys-fs/lvm2 )
	sys-fs/sysfsutils"

PATCHES=( )

pkg_setup() {
	linux-info_pkg_setup
	CONFIG_CHECK_MODULES="ISCSI_TCP"
	if linux_config_exists; then
		for module in ${CONFIG_CHECK_MODULES}; do
			linux_chkconfig_present ${module} || ewarn "${module} needs to be built as module (builtin doesn't work)"
		done
	fi
	enewgroup cinder
	enewuser cinder -1 -1 /var/lib/cinder cinder
}

#python_compile_all() { leave for next attempt
#	use doc && emake -C doc html
#}

python_test() {
	# Let's track progress of this # https://bugs.launchpad.net/swift/+bug/1249727
	nosetests -I test_wsgi.py cinder/tests/ || die "tests failed under python2.7"
}

python_install() {
	distutils-r1_python_install
	keepdir /etc/cinder
	dodir /etc/cinder/rootwrap.d

	for svc in api scheduler volume; do
		newinitd "${FILESDIR}/cinder.initd" cinder-${svc}
	done

	insinto /etc/cinder
	newins "${S}/etc/cinder/cinder.conf.sample" "cinder.conf"
	newins "${S}/etc/cinder/api-paste.ini" "api-paste.ini"
	newins "${S}/etc/cinder/logging_sample.conf" "logging_sample.conf"
	newins "${S}/etc/cinder/policy.json" "policy.json"
	newins "${S}/etc/cinder/rootwrap.conf" "rootwrap.conf"
	insinto /etc/cinder/rootwrap.d
	newins "${S}/etc/cinder/rootwrap.d/volume.filters" "volume.filters"

	dodir /var/log/cinder
	fowners cinder:cinder /var/log/cinder

	#add sudoers definitions for user nova
	insinto /etc/sudoers.d/
	insopts -m 0440 -o root -g root
	newins "${FILESDIR}/cinder.sudoersd" cinder
}
