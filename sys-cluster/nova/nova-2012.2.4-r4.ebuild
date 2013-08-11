# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/nova/nova-2012.2.4-r4.ebuild,v 1.1 2013/08/11 03:48:28 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="Nova is a cloud computing fabric controller (main part of an
IaaS system). It is written in Python."
HOMEPAGE="https://launchpad.net/nova"
SRC_URI="http://launchpad.net/${PN}/folsom/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="=dev-python/amqplib-0.6.1
		>=dev-python/anyjson-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-0.7.8
		<=dev-python/sqlalchemy-0.7.9
		=dev-python/boto-2.1.1[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.9.17
		=dev-python/kombu-1.0.4-r1[${PYTHON_USEDEP}]
		=dev-python/routes-1.12.3-r1[${PYTHON_USEDEP}]
		=dev-python/webob-1.0.8-r1[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.1[${PYTHON_USEDEP}]
		=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-migrate-0.7.2
		dev-python/netaddr
		=dev-python/suds-0.4
		dev-python/paramiko[${PYTHON_USEDEP}]
		>=dev-python/Babel-0.9.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/setuptools-git-0.4[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.5.0[${PYTHON_USEDEP}]
		<dev-python/python-glanceclient-2[${PYTHON_USEDEP}]
		>=dev-python/python-quantumclient-2.1[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/nova-folsom-4-CVE-2013-2030.patch"
	"${FILESDIR}/nova-folsom-4-CVE-2013-2096.patch"
	"${FILESDIR}/2012.2.4-CVE-2013-2256.patch"
	"${FILESDIR}/2012.2.4-CVE-2013-4185.patch"
)

python_install() {
	distutils-r1_python_install
	keepdir /etc/nova
	insinto /etc/nova

	newins "etc/nova/nova.conf.sample" "nova.conf"
	newins "etc/nova/api-paste.ini" "api-paste.ini"
	newins "etc/nova/logging_sample.conf" "logging_sample.conf"
	newins "etc/nova/policy.json" "policy.json"
	newins "etc/nova/rootwrap.conf" "rootwrap.conf"
	insinto /etc/nova/rootwrap.d
	doins "etc/nova/rootwrap.d/api-metadata.filters"
	doins "etc/nova/rootwrap.d/compute.filters"
	doins "etc/nova/rootwrap.d/network.filters"
	doins "etc/nova/rootwrap.d/volume.filters"

	#copy migration conf file (not coppied on install via setup.py script)
	insinto /usr/$(get_libdir)/python2.7/site-packages/nova/db/sqlalchemy/migrate_repo/
	doins "nova/db/sqlalchemy/migrate_repo/migrate.cfg"

	#copy the CA cert dir (not coppied on install via setup.py script)
	cp -R "${S}/nova/CA" "${D}/usr/$(get_libdir)/python2.7/site-packages/nova/" || die "isntalling CA files failed"
}
