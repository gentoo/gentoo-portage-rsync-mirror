# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/neutron/neutron-2013.2.9999.ebuild,v 1.6 2013/12/19 05:57:35 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="A virtual network service for Openstack."
HOMEPAGE="https://launchpad.net/neutron"
EGIT_REPO_URI="https://github.com/openstack/neutron.git"
EGIT_BRANCH="stable/havana"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+dhcp doc +l3 +metadata +openvswitch +server test sqlite mysql postgres"
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
				<dev-python/sphinx-1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
				>=dev-python/webtest-2.0[${PYTHON_USEDEP}]
				dev-python/configobj[${PYTHON_USEDEP}]
				<dev-python/hacking-0.8[${PYTHON_USEDEP}]
				>=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
				dev-python/mimeparse[${PYTHON_USEDEP}] )"

RDEPEND="dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
		>=dev-python/amqplib-0.6.1-r1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.8[${PYTHON_USEDEP}]
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
		>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.10[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/python-novaclient-2.15.0[${PYTHON_USEDEP}]
		dev-python/pyudev[${PYTHON_USEDEP}]
		sys-apps/iproute2
		openvswitch? ( net-misc/openvswitch )
		dhcp? ( net-dns/dnsmasq[dhcp-tools] )"

PATCHES=( "${FILESDIR}/sphinx_mapping.patch"
		"${FILESDIR}/nicira.patch" )

pkg_setup() {
	enewgroup neutron
	enewuser neutron -1 -1 /var/lib/neutron neutron
}

pkg_config() {
	fperms 0700 /var/log/neutron
	fowners neutron:neutron /var/log neutron
}

src_prepare() {
	#it's /bin/ip not /sbin/ip
	sed -i 's/sbin\/ip\,/bin\/ip\,/g' etc/neutron/rootwrap.d/*
	distutils-r1_src_prepare
}

python_compile_all() {
	use doc && make -C doc html
}

python_test() {
	# https://bugs.launchpad.net/neutron/+bug/1234857
	# https://bugs.launchpad.net/swift/+bug/1249727
	# https://bugs.launchpad.net/neutron/+bug/1251657
	# turn multiprocessing off, testr will use it --parallel
	local DISTUTILS_NO_PARALLEL_BUILD=1
	# Move tests out that attempt net connection, have failures
	mv $(find . -name test_ovs_tunnel.py) . || die
	sed -e 's:test_app_using_ipv6_and_ssl:_&:' \
		-e 's:test_start_random_port_with_ipv6:_&:' \
		-i neutron/tests/unit/test_wsgi.py || die
	testr init
	testr run --parallel || die "failed testsuite under python2.7"
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

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	distutils-r1_python_install_all
}
