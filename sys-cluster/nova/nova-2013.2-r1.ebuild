# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/nova/nova-2013.2-r1.ebuild,v 1.4 2013/11/26 09:14:41 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils multilib

DESCRIPTION="A cloud computing fabric controller (main part of an IaaS system) written in Python."
HOMEPAGE="https://launchpad.net/nova"
SRC_URI="http://launchpad.net/${PN}/havana/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+api +cert +compute +conductor +consoleauth +kvm +network +novncproxy +scheduler +spicehtml5proxy +xvpvncproxy sqlite mysql postgres sqlite test xen"
REQUIRED_USE="|| ( mysql postgres sqlite )
			  || ( kvm xen )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		app-admin/sudo
		test? ( >=dev-python/hacking-0.5[${PYTHON_USEDEP}]
			<dev-python/hacking-0.8[${PYTHON_USEDEP}]
			>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
			dev-python/feedparser[${PYTHON_USEDEP}]
			>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
			>=dev-python/mock-1.0[${PYTHON_USEDEP}]
			>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
			dev-python/mysql-python[${PYTHON_USEDEP}]
			>=dev-python/pylint-0.25.2[${PYTHON_USEDEP}]
			dev-python/subunit[${PYTHON_USEDEP}]
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			dev-python/oslo-sphinx[${PYTHON_USEDEP}]
			>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
			>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}]
		)"
RDEPEND="sqlite? ( >=dev-python/sqlalchemy-0.7.8[sqlite,${PYTHON_USEDEP}]
	          <dev-python/sqlalchemy-0.7.99[sqlite,${PYTHON_USEDEP}] )
		mysql? ( >=dev-python/sqlalchemy-0.7.8[mysql,${PYTHON_USEDEP}]
			<dev-python/sqlalchemy-0.7.99[mysql,${PYTHON_USEDEP}] )
		postgres? ( >=dev-python/sqlalchemy-0.7.8[postgres,${PYTHON_USEDEP}]
			<dev-python/sqlalchemy-0.7.99[postgres,${PYTHON_USEDEP}] )
		>=dev-python/amqplib-0.6.1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/boto-2.4.0[${PYTHON_USEDEP}]
		!~dev-python/boto-2.13.0[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.13.0[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		>=dev-python/kombu-2.4.8[${PYTHON_USEDEP}]
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3-r1[${PYTHON_USEDEP}]
		>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
		<dev-python/webob-1.3[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-migrate-0.7.2[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		>=dev-python/suds-0.4[${PYTHON_USEDEP}]
		>=dev-python/paramiko-1.8.0[${PYTHON_USEDEP}]
		dev-python/pyasn1[${PYTHON_USEDEP}]
		>=dev-python/Babel-0.9.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.5[${PYTHON_USEDEP}]
		>=dev-python/python-neutronclient-2.3.0[${PYTHON_USEDEP}]
		<=dev-python/python-neutronclient-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.10[${PYTHON_USEDEP}]
		>=dev-python/websockify-0.5.1[${PYTHON_USEDEP}]
		<dev-python/websockify-0.6[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		app-emulation/libvirt[${PYTHON_USEDEP}]
		novncproxy? ( www-apps/novnc )
		sys-apps/iproute2
		net-misc/openvswitch
		sys-fs/sysfsutils
		sys-fs/multipath-tools
		kvm? ( app-emulation/qemu )
		xen? ( app-emulation/xen
			   app-emulation/xen-tools )"

PATCHES=(
)

pkg_setup() {
	enewgroup nova
	enewuser nova -1 -1 /var/lib/nova nova
}

python_test() {
	# https://bugs.launchpad.net/nova/+bug/1254943
	sed -e 's:test_download_module_filesystem_match:_&:' \
                -e' s:test_download_module_no_filesystem_match:_&:' \
                -e 's:test_download_module_mountpoints:_&:' \
                -e 's:test_download_file_url:_&:' \
                -i nova/tests/image/test_glance.py || die
	# Using nosetests until upstream (ever) get the suite fixed. 
	# This gives nova @ minimum a token test phase
	nosetests nova/tests/[c-g]*/ \
		nova/tests/image \
		nova/tests/[k-n]*/ \
		-e update_test nova/tests/objects \
		-I test_pci_whitelist.py -I test_pci_request.py nova/tests/pci \
		nova/tests/[s-v]*/ \
		nova/tests/test_*.py \
		|| die "tests failed under python2.7"
}

python_install() {
	distutils-r1_python_install
	newconfd "${FILESDIR}/nova-confd" "nova"
	newinitd "${FILESDIR}/nova-initd" "nova"
	use api && dosym /etc/init.d/nova /etc/init.d/nova-api
	use cert && dosym /etc/init.d/nova /etc/init.d/nova-cert
	use compute && dosym /etc/init.d/nova /etc/init.d/nova-compute
	use conductor && dosym /etc/init.d/nova /etc/init.d/nova-conductor
	use consoleauth && dosym /etc/init.d/nova /etc/init.d/nova-consoleauth
	use network &&  dosym /etc/init.d/nova /etc/init.d/nova-network
	use novncproxy &&dosym /etc/init.d/nova /etc/init.d/nova-novncproxy
	use scheduler && dosym /etc/init.d/nova /etc/init.d/nova-scheduler
	use spicehtml5proxy && dosym /etc/init.d/nova /etc/init.d/nova-spicehtml5proxy
	use xvpvncproxy && dosym /etc/init.d/nova /etc/init.d/nova-xvpncproxy

	diropts -m 0750
	dodir /var/run/nova /var/log/nova /var/lock/nova
	fowners nova:nova /var/log/nova /var/lock/nova /var/run/nova

	diropts -m 0755
	dodir /var/lib/nova/instances
	fowners nova:nova /var/lib/nova/instances

	keepdir /etc/nova
	insinto /etc/nova
	newins "etc/nova/nova.conf.sample" "nova.conf"
	doins "etc/nova/api-paste.ini"
	doins "etc/nova/logging_sample.conf"
	doins "etc/nova/policy.json"
	doins "etc/nova/rootwrap.conf"
	insinto /etc/nova/rootwrap.d
	doins "etc/nova/rootwrap.d/api-metadata.filters"
	doins "etc/nova/rootwrap.d/compute.filters"
	doins "etc/nova/rootwrap.d/network.filters"

	#copy migration conf file (not coppied on install via setup.py script)
	insinto /usr/$(get_libdir)/python2.7/site-packages/nova/db/sqlalchemy/migrate_repo/
	doins "nova/db/sqlalchemy/migrate_repo/migrate.cfg"

	#copy the CA cert dir (not coppied on install via setup.py script)
	cp -R "${S}/nova/CA" "${D}/usr/$(get_libdir)/python2.7/site-packages/nova/" || die "isntalling CA files failed"

	#add sudoers definitions for user nova
	insinto /etc/sudoers.d/
	doins "${FILESDIR}/nova-sudoers"
}
