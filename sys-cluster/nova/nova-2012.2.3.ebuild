# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/nova/nova-2012.2.3.ebuild,v 1.2 2013/02/20 06:13:35 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

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
		>=dev-python/anyjson-0.2.4
		>=dev-python/sqlalchemy-0.7.8
		<=dev-python/sqlalchemy-0.7.9
		=dev-python/boto-2.1.1
		>=dev-python/eventlet-0.9.17
		=dev-python/kombu-1.0.4
		=dev-python/routes-1.12.3
		=dev-python/webob-1.0.8
		>=dev-python/greenlet-0.3.1
		=dev-python/pastedeploy-1.5.0
		dev-python/paste
		>=dev-python/sqlalchemy-migrate-0.7.2
		dev-python/netaddr
		=dev-python/suds-0.4
		dev-python/paramiko
		>=dev-python/Babel-0.9.6
		>=dev-python/iso8601-0.1.4
		dev-python/httplib2
		>=dev-python/setuptools-git-0.4
		>=dev-python/python-glanceclient-0.5.0
		<dev-python/python-glanceclient-2
		>=dev-python/python-quantumclient-2.1"

PATCHES=( "${FILESDIR}/nova-folsom-CVE-2013-1664.patch" )

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
}
