# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/nova/nova-2013.2.1-r1.ebuild,v 1.2 2014/01/08 06:00:45 vapier Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils multilib user

DESCRIPTION="A cloud computing fabric controller (main part of an IaaS system) written in Python."
HOMEPAGE="https://launchpad.net/nova"
SRC_URI="http://launchpad.net/${PN}/havana/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+api +cert +compute +conductor +consoleauth +kvm +network +novncproxy +scheduler +spicehtml5proxy +xvpvncproxy sqlite mysql postgres xen"
REQUIRED_USE="|| ( mysql postgres sqlite )
			  || ( kvm xen )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		app-admin/sudo"

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
		>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.8[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.5[${PYTHON_USEDEP}]
		>=dev-python/python-neutronclient-2.3.0[${PYTHON_USEDEP}]
		<=dev-python/python-neutronclient-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.10[${PYTHON_USEDEP}]
		>=dev-python/websockify-0.5.1[${PYTHON_USEDEP}]
		<dev-python/websockify-0.6[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		dev-python/libvirt-python[${PYTHON_USEDEP}]
		novncproxy? ( www-apps/novnc )
		sys-apps/iproute2
		net-misc/openvswitch
		sys-fs/sysfsutils
		sys-fs/multipath-tools
		kvm? ( app-emulation/qemu )
		xen? ( app-emulation/xen
			   app-emulation/xen-tools )"

PATCHES=(
	"${FILESDIR}/CVE-2013-6437-2012.2.1.patch"
)

pkg_setup() {
	enewgroup nova
	enewuser nova -1 -1 /var/lib/nova nova
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
