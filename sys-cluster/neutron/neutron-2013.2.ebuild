# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/neutron/neutron-2013.2.ebuild,v 1.2 2013/11/10 23:04:52 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

#restricted due to packages missing and bad depends in the test ==webob-1.0.8   
RESTRICT="test"
DESCRIPTION="Quantum is a virtual network service for Openstack."
HOMEPAGE="https://launchpad.net/neutron"
SRC_URI="http://launchpad.net/${PN}/havana/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dhcp +l3 +metadata +openvswitch +server test sqlite mysql postgres"
REQUIRED_USE="|| ( mysql postgres sqlite )"

#the cliff dep is as below because it depends on pyparsing, which only has 2.7 OR 3.2, not both
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		app-admin/sudo
		test? ( >=dev-python/cliff-1.4.3[${PYTHON_USEDEP}]
				>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
				>=dev-python/mock-1.0[${PYTHON_USEDEP}]
				>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
				dev-python/subunit[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
				>=dev-python/webtest-2.0[${PYTHON_USEDEP}]
				dev-python/configobj[${PYTHON_USEDEP}] )"
RDEPEND="dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
		>=dev-python/amqplib-0.6.1-r1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/Babel-0.9.6[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		dev-python/jsonrpclib[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		>=dev-python/kombu-2.4.8[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		>=dev-python/python-neutronclient-2.3.0[${PYTHON_USEDEP}]
		<=dev-python/python-neutronclient-3.0.0[${PYTHON_USEDEP}]
		sqlite? ( >=dev-python/sqlalchemy-0.7.8[sqlite,${PYTHON_USEDEP}]
	          <dev-python/sqlalchemy-0.7.99[sqlite,${PYTHON_USEDEP}] )
		mysql? ( >=dev-python/sqlalchemy-0.7.8[mysql,${PYTHON_USEDEP}]
	         <dev-python/sqlalchemy-0.7.99[mysql,${PYTHON_USEDEP}] )
		postgres? ( >=dev-python/sqlalchemy-0.7.8[postgres,${PYTHON_USEDEP}]
	            <dev-python/sqlalchemy-0.7.99[postgres,${PYTHON_USEDEP}] )
		>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
		<dev-python/webob-1.3[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/alembic-0.4.1[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.10[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/python-novaclient-2.15.0[${PYTHON_USEDEP}]
		dev-python/pyudev[${PYTHON_USEDEP}]
		net-misc/bridge-utils
		openvswitch? ( net-misc/openvswitch )
		dhcp? ( net-dns/dnsmasq[dhcp-tools] )"

pkg_setup() {
	enewgroup neutron
	enewuser neutron -1 -1 /var/lib/neutron neutron
}

src_prepare() {
	#it's /bin/ip not /sbin/ip
	sed -i 's/sbin\/ip\,/bin\/ip\,/g' etc/neutron/rootwrap.d/*
}

python_install() {
	distutils-r1_python_install
	newconfd "${FILESDIR}/neutron-confd" "neutron"
	newinitd "${FILESDIR}/neutron-initd" "neutron"

	use server && dosym /etc/init.d/neutron /etc/init.d/neutron-server
	use dhcp && dosym /etc/init.d/neutron /etc/init.d/neutron-dhcp-agent
	use l3 && dosym /etc/init.d/neutron /etc/init.d/neutron-l3-agent
	use metadata && dosym /etc/init.d/neutron /etc/init.d/neutron-metadata-agent
	use openvswitch && dosym /etc/init.d/neutron /etc/init.d/neutron-openvswitch-agent

	diropts -m 750
	dodir /var/log/neutron /var/log/neutron
	fowners neutron:neutron /var/log/neutron
	keepdir /etc/neutron
	insinto /etc/neutron

	doins "etc/api-paste.ini"
	doins "etc/dhcp_agent.ini"
	doins "etc/l3_agent.ini"
	doins "etc/policy.json"
	doins "etc/neutron.conf"
	doins "etc/rootwrap.conf"
	insinto /etc
	doins -r "etc/neutron/"

	#remove the etc stuff from usr...
	rm -R "${D}/usr/etc/"

	insinto "/usr/lib64/python2.7/site-packages/neutron/db/migration/alembic_migrations/"
	doins -r "neutron/db/migration/alembic_migrations/versions"

	#add sudoers definitions for user neutron
	insinto /etc/sudoers.d/
	doins "${FILESDIR}/neutron-sudoers"
}

pkg_config() {
	fperms 0700 /var/log/neutron
	fowners neutron:neutron /var/log neutron
}
