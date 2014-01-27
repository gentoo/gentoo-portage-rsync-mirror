# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/nova/nova-2013.1.4-r5.ebuild,v 1.1 2014/01/27 08:44:51 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils multilib user

DESCRIPTION="A cloud computing fabric controller (main part of an IaaS system) written in Python."
HOMEPAGE="https://launchpad.net/nova"
SRC_URI="http://launchpad.net/${PN}/grizzly/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+api +cert +compute +conductor +consoleauth +kvm +network +novncproxy +scheduler +spicehtml5proxy +xvpvncproxy xen sqlite mysql postgres"
REQUIRED_USE="|| ( mysql postgres sqlite )
			  || ( kvm xen )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		app-admin/sudo"

RDEPEND=">=dev-python/amqplib-0.6.1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/cheetah-2.4.4[${PYTHON_USEDEP}]
		sqlite? ( >=dev-python/sqlalchemy-0.7.8[sqlite,${PYTHON_USEDEP}]
	          <dev-python/sqlalchemy-0.7.10[sqlite,${PYTHON_USEDEP}] )
		mysql? ( >=dev-python/sqlalchemy-0.7.8[mysql,${PYTHON_USEDEP}]
	         <dev-python/sqlalchemy-0.7.10[mysql,${PYTHON_USEDEP}] )
		postgres? ( >=dev-python/sqlalchemy-0.7.8[postgres,${PYTHON_USEDEP}]
	            <dev-python/sqlalchemy-0.7.10[postgres,${PYTHON_USEDEP}] )
		dev-python/boto[${PYTHON_USEDEP}]
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.9.17[${PYTHON_USEDEP}]
		>=dev-python/kombu-1.0.4-r1[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3-r1[${PYTHON_USEDEP}]
		~dev-python/webob-1.2.3[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.1[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-migrate-0.7.2[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		>=dev-python/suds-0.4[${PYTHON_USEDEP}]
		dev-python/paramiko[${PYTHON_USEDEP}]
		dev-python/pyasn1[${PYTHON_USEDEP}]
		>=dev-python/Babel-0.9.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/setuptools-git-0.4[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.5.0[${PYTHON_USEDEP}]
		<dev-python/python-glanceclient-2[${PYTHON_USEDEP}]
		>=dev-python/python-neutronclient-2.2.0[${PYTHON_USEDEP}]
		<=dev-python/python-neutronclient-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.7[${PYTHON_USEDEP}]
		<dev-python/websockify-0.4[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.1.0[${PYTHON_USEDEP}]
		<dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]
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
	"${FILESDIR}/CVE-2013-4463_4469-grizzly.patch"
	"${FILESDIR}/CVE-2013-4497-grizzly-1.patch"
	"${FILESDIR}/CVE-2013-4497-grizzly-2.patch"
	"${FILESDIR}/CVE-2013-6419_2013.1.4.patch"
	"${FILESDIR}/CVE-2013-6437-2012.1.4.patch"
	"${FILESDIR}/CVE-2013-7048-grizzly.patch"
	"${FILESDIR}/CVE-2013-7130-stable-grizzly.patch"
)

pkg_setup() {
	enewgroup nova
	enewuser nova -1 -1 /var/lib/nova nova
}

src_prepare() {
	sed -i 's/setuptools_git>=0.4//g' "${S}/setup.py"
	distutils-r1_src_prepare
}

#python_test() {
#	nosetests || die
#}

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
