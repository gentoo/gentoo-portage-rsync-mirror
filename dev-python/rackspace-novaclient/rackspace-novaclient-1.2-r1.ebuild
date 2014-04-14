# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rackspace-novaclient/rackspace-novaclient-1.2-r1.ebuild,v 1.1 2014/04/14 19:27:19 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Nova API"
HOMEPAGE="https://github.com/rackerlabs/rackspace-novaclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/python-novaclient[${PYTHON_USEDEP}]
		dev-python/rackspace-auth-openstack[${PYTHON_USEDEP}]
		dev-python/os-diskconfig-python-novaclient-ext[${PYTHON_USEDEP}]
		dev-python/rax-backup-schedule-python-novaclient-ext[${PYTHON_USEDEP}]
		dev-python/os-networksv2-python-novaclient-ext[${PYTHON_USEDEP}]
		dev-python/rax-default-network-flags-python-novaclient-ext[${PYTHON_USEDEP}]"

python_prepare() {
	mkdir "${BUILD_DIR}" || die
}
