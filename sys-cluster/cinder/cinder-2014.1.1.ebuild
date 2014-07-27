# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cinder/cinder-2014.1.1.ebuild,v 1.3 2014/07/26 23:09:50 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils user

DESCRIPTION="Cinder is the OpenStack Block storage service, a spin out of nova-volumes."
HOMEPAGE="https://launchpad.net/cinder"
SRC_URI="http://launchpad.net/${PN}/icehouse/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+api +scheduler +volume iscsi lvm mysql postgres sqlite test"
REQUIRED_USE="|| ( mysql postgres sqlite )"

#sudo is a build dep because I want the sudoers.d directory to exist, lazy.
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.6[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		app-admin/sudo
		test? ( >=dev-python/hacking-0.8.0[${PYTHON_USEDEP}]
				<dev-python/hacking-0.9[${PYTHON_USEDEP}]
				>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
				>=dev-python/hp3parclient-3.0[${PYTHON_USEDEP}]
				<dev-python/hp3parclient-4.0[${PYTHON_USEDEP}]
				>=dev-python/mock-1.0[${PYTHON_USEDEP}]
				>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
				dev-python/mysql-python[${PYTHON_USEDEP}]
				dev-python/psycopg[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				<dev-python/sphinx-1.2[${PYTHON_USEDEP}]
				>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.34[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
				dev-python/oslo-sphinx[${PYTHON_USEDEP}] )"

RDEPEND=">=dev-python/amqplib-0.6.1-r1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.9[${PYTHON_USEDEP}]
		>=dev-python/kombu-2.4.8[${PYTHON_USEDEP}]
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		>=dev-python/netaddr-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-messaging-1.3.0[${PYTHON_USEDEP}]
		dev-python/oslo-rootwrap[${PYTHON_USEDEP}]
		>=dev-python/paramiko-1.9.0[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/python-novaclient-2.17.0[${PYTHON_USEDEP}]
		>=dev-python/python-swiftclient-1.6[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
		>=dev-python/taskflow-0.1.3[${PYTHON_USEDEP}]
		<dev-python/taskflow-0.2[${PYTHON_USEDEP}]
		>=dev-python/rtslib-fb-2.1.39[${PYTHON_USEDEP}]
		>=dev-python/six-1.5.2[${PYTHON_USEDEP}]
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
		>=dev-python/sqlalchemy-migrate-0.9[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.14[${PYTHON_USEDEP}]
		>=dev-python/suds-0.4[${PYTHON_USEDEP}]
		>=dev-python/webob-1.2.3-r1[${PYTHON_USEDEP}]
		iscsi? (
			>=sys-block/iscsitarget-1.4.20.2_p20130821
			sys-block/open-iscsi )
		lvm? ( sys-fs/lvm2 )
		sys-fs/sysfsutils"

PATCHES=( )

pkg_setup() {
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
