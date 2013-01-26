# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/quantum/quantum-2012.2.1.ebuild,v 1.1 2013/01/26 08:58:44 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Quantum is a virtual network service for Openstack."
HOMEPAGE="https://launchpad.net/quantum"
SRC_URI="http://launchpad.net/${PN}/folsom/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/paste
		=dev-python/pastedeploy-1.5.0
		>=dev-python/routes-1.12.3
		=dev-python/amqplib-0.6.1
		=dev-python/anyjson-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.9.17
		>=dev-python/greenlet-0.3.1
		dev-python/httplib2
		>=dev-python/iso8601-0.1.4
		=dev-python/kombu-1.0.4
		dev-python/lxml
		dev-python/netaddr
		>=dev-python/python-quantumclient-2.0[${PYTHON_USEDEP}]
		dev-python/pyudev
		>dev-python/sqlalchemy-0.6.4
		<=dev-python/sqlalchemy-0.7.9
		=dev-python/webob-1.0.8"

python_install() {
	distutils-r1_python_install
	keepdir /etc/quantum
	insinto /etc/quantum

	doins "etc/api-paste.ini"
	doins "etc/dhcp_agent.ini"
	doins "etc/l3_agent.ini"
	doins "etc/policy.json"
	doins "etc/quantum.conf"
	doins "etc/rootwrap.conf"
	insinto /etc
	doins -r "etc/quantum/"

	#remove the etc stuff from usr...
	rm -R "${D}/usr/etc/"
}
