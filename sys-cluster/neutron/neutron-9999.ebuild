# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/neutron/neutron-9999.ebuild,v 1.12 2014/07/26 23:01:44 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2 user

#restricted due to packages missing and bad depends in the test ==webob-1.0.8
RESTRICT="test"
DESCRIPTION="A virtual network service for Openstack."
HOMEPAGE="https://launchpad.net/neutron"
EGIT_REPO_URI="https://github.com/openstack/neutron.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+dhcp +l3 +metadata +openvswitch +server test sqlite mysql postgres"
REQUIRED_USE="|| ( mysql postgres sqlite )"

#the cliff dep is as below because it depends on pyparsing, which only has 2.7 OR 3.2, not both
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		app-admin/sudo
		test? ( dev-python/cliff[${PYTHON_USEDEP}]
				dev-python/configobj[${PYTHON_USEDEP}]
				dev-python/coverage[${PYTHON_USEDEP}]
				>=dev-python/mock-1.0[${PYTHON_USEDEP}]
				~dev-python/mox-0.5.3[${PYTHON_USEDEP}]
				dev-python/nose[${PYTHON_USEDEP}]
				dev-python/nosehtmloutput[${PYTHON_USEDEP}]
				dev-python/nosexcover[${PYTHON_USEDEP}]
				dev-python/openstack-nose-plugin[${PYTHON_USEDEP}]
				~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				~dev-python/webtest-1.3.3[${PYTHON_USEDEP}] )"
RDEPEND=">=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
		>=dev-python/alembic-0.4.1[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
		>=dev-python/amqplib-0.6.1-r1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.9.17[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.1[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/kombu-1.0.4-r1[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.2.0[${PYTHON_USEDEP}]
		dev-python/python-novaclient[${PYTHON_USEDEP}]
		>=dev-python/python-neutronclient-2.3.0[${PYTHON_USEDEP}]
		<=dev-python/python-neutronclient-3.0.0[${PYTHON_USEDEP}]
		dev-python/pyudev[${PYTHON_USEDEP}]
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
		>=dev-python/webob-1.2[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.1.0[${PYTHON_USEDEP}]
		<dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		net-misc/bridge-utils
		net-misc/openvswitch
		dhcp? ( net-dns/dnsmasq[dhcp-tools] )"

pkg_setup() {
	enewgroup neutron
	enewuser neutron -1 -1 /var/lib/neutron neutron
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
	dodir /var/log/neutron /var/log/quantum
	fowners neutron:neutron /var/log/neutron
	keepdir /etc/neutron
	insinto /etc/neutron

	#it's /bin/ip not /sbin/ip
	sed -i 's/sbin\/ip\,/bin\/ip\,/g' "etc/quantum/rootwrap.d/*"

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
