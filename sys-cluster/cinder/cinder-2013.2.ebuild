# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cinder/cinder-2013.2.ebuild,v 1.2 2013/11/14 04:20:23 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="Cinder is the OpenStack Block storage service. This is a spin out
of nova-volumes."
HOMEPAGE="https://launchpad.net/cinder"
SRC_URI="http://launchpad.net/${PN}/havana/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+api +scheduler +volume mysql postgres sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

#sudo is a build dep because I want the sudoers.d directory to exist, lazy.
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		app-admin/sudo"

RDEPEND="=dev-python/amqplib-0.6.1-r1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/kombu-2.4.8[${PYTHON_USEDEP}]
		>=dev-python/lockfile-0.8[${PYTHON_USEDEP}]
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/paramiko-1.8.0[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/python-novaclient-2.15.0[${PYTHON_USEDEP}]
		>=dev-python/python-swiftclient-1.5[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		sqlite? ( >=dev-python/sqlalchemy-0.7.8[sqlite,${PYTHON_USEDEP}]
	          <dev-python/sqlalchemy-0.7.99[sqlite,${PYTHON_USEDEP}] )
		mysql? ( >=dev-python/sqlalchemy-0.7.8[mysql,${PYTHON_USEDEP}]
	         <dev-python/sqlalchemy-0.7.99[mysql,${PYTHON_USEDEP}] )
		postgres? ( >=dev-python/sqlalchemy-0.7.8[postgres,${PYTHON_USEDEP}]
	            <dev-python/sqlalchemy-0.7.99[postgres,${PYTHON_USEDEP}] )
		>=dev-python/sqlalchemy-migrate-0.7.2[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.10[${PYTHON_USEDEP}]
		>=dev-python/suds-0.4[${PYTHON_USEDEP}]
		>=dev-python/webob-1.2.3-r1[${PYTHON_USEDEP}]
		<dev-python/webob-1.3[${PYTHON_USEDEP}]
		>=sys-block/iscsitarget-1.4.20.2_p20130821
		sys-fs/lvm2
		sys-block/open-iscsi
		sys-fs/sysfsutils"

PATCHES=( )

pkg_setup() {
	enewgroup cinder
	enewuser cinder -1 -1 /var/lib/cinder cinder
}

python_install() {
	distutils-r1_python_install
	keepdir /etc/cinder
	dodir /etc/cinder/rootwrap.d
	newinitd "${FILESDIR}/cinder-init" "cinder"
	newconfd "${FILESDIR}/cinder-confd" "cinder"
	use api && dosym /etc/init.d/cinder /etc/init.d/cinder-api
	use scheduler && dosym /etc/init.d/cinder /etc/init.d/cinder-scheduler
	use volume && dosym /etc/init.d/cinder /etc/init.d/cinder-volume

	insinto /etc/cinder
	newins "${S}/etc/cinder/cinder.conf.sample" "cinder.conf"
	newins "${S}/etc/cinder/api-paste.ini" "api-paste.ini"
	newins "${S}/etc/cinder/logging_sample.conf" "logging_sample.conf"
	newins "${S}/etc/cinder/policy.json" "policy.json"
	newins "${S}/etc/cinder/rootwrap.conf" "rootwrap.conf"
	insinto /etc/cinder/rootwrap.d
	newins "${S}/etc/cinder/rootwrap.d/volume.filters" "volume.filters"

	#add sudoers definitions for user nova
	insinto /etc/sudoers.d/
	doins "${FILESDIR}/cinder-sudoers"
	dodir /var/log/cinder
	fowners cinder:cinder /var/log/cinder
}
