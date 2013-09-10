# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/nova/nova-9999.ebuild,v 1.7 2013/09/10 05:04:23 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils git-2 multilib

DESCRIPTION="Nova is a cloud computing fabric controller (main part of an
IaaS system). It is written in Python."
HOMEPAGE="https://launchpad.net/nova"
EGIT_REPO_URI="https://github.com/openstack/nova.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+api +cert +compute +conductor +consoleauth +network +novncproxy +scheduler +spicehtml5proxy +xvpvncproxy"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		app-admin/sudo"

RDEPEND=">=dev-python/amqplib-0.6.1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-0.7.8
		<=dev-python/sqlalchemy-0.7.99
		dev-python/boto[${PYTHON_USEDEP}]
		>=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
		<dev-python/d2to1-0.3[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.9.17[${PYTHON_USEDEP}]
		>=dev-python/jinja-2.0[${PYTHON_USEDEP}]
		<dev-python/jinja-3[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-1.3.0[${PYTHON_USEDEP}]
		!~dev-python/jsonschema-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/kombu-1.0.4-r1[${PYTHON_USEDEP}]
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.16[${PYTHON_USEDEP}]
		<dev-python/pbr-0.6[${PYTHON_USEDEP}]
		>=dev-python/routes-1.12.3-r1[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		~dev-python/webob-1.2.3[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.1[${PYTHON_USEDEP}]
		>=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-migrate-0.7.2
		>=dev-python/netaddr-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/suds-0.4
		dev-python/paramiko[${PYTHON_USEDEP}]
		dev-python/pyasn1[${PYTHON_USEDEP}]
		>=dev-python/Babel-0.9.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/python-cinderclient-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/python-neutronclient-2.3.0[${PYTHON_USEDEP}]
		<=dev-python/python-neutronclient-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.10[${PYTHON_USEDEP}]
		>=dev-python/websockify-0.5.1[${PYTHON_USEDEP}]
		<dev-python/websockify-0.6[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.1.0[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]"
#oslo.config-1.2 is required but not released yet

PATCHES=(
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
	use novncproxy &&dosym /etc/init.d/nova /etc/init.d/nova-nonvncproxy
	use scheduler && dosym /etc/init.d/nova /etc/init.d/nova-scheduler
	use spicehtml5proxy && dosym /etc/init.d/nova /etc/init.d/nova-spicehtml5proxy
	use xvpvncproxy && dosym /etc/init.d/nova /etc/init.d/nova-xvpncproxy

	dodir /var/log/nova
	fowners nova:nova /var/log/nova

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
