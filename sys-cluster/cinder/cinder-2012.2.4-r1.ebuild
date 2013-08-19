# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cinder/cinder-2012.2.4-r1.ebuild,v 1.2 2013/08/19 02:41:47 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="Cinder is the OpenStack Block storage service. This is a spin out
of nova-volumes."
HOMEPAGE="https://launchpad.net/cinder"
SRC_URI="http://launchpad.net/${PN}/folsom/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="~dev-python/amqplib-0.6.1[${PYTHON_USEDEP}]
		>=dev-python/anyjson-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.9.17[${PYTHON_USEDEP}]
		~dev-python/kombu-1.0.4
		~dev-python/lockfile-0.8
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		~dev-python/routes-1.12.3[${PYTHON_USEDEP}]
		>=dev-python/webob-1.0.8[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.3.1[${PYTHON_USEDEP}]
		~dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
		dev-python/paste[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-0.7.3
		<=dev-python/sqlalchemy-0.7.9
		>=dev-python/sqlalchemy-migrate-0.7.2[${PYTHON_USEDEP}]
		>=dev-python/stevedore-0.8
		~dev-python/suds-0.4
		dev-python/paramiko[${PYTHON_USEDEP}]
		>=dev-python/Babel-0.9.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/setuptools-git-0.4[${PYTHON_USEDEP}]
		>=dev-python/python-glanceclient-0.5.0
		<dev-python/python-glanceclient-2
		>=dev-python/python-keystoneclient-0.2.0[${PYTHON_USEDEP}]"

PATCHES=(
)

python_install() {
	distutils-r1_python_install
	keepdir /etc/cinder
	keepdir /etc/cinder/rootwrap.d
	insinto /etc/cinder

	newins "${S}/etc/cinder/cinder.conf.sample" "cinder.conf"
	newins "${S}/etc/cinder/api-paste.ini" "api-paste.ini"
	newins "${S}/etc/cinder/logging_sample.conf" "logging_sample.conf"
	newins "${S}/etc/cinder/policy.json" "policy.json"
	newins "${S}/etc/cinder/rootwrap.conf" "rootwrap.conf"
	insinto /etc/cinder/rootwrap.d
	newins "${S}/etc/cinder/rootwrap.d/volume.filters" "volume.filters"
}
