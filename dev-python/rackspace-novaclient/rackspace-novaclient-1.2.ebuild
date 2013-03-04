# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rackspace-novaclient/rackspace-novaclient-1.2.ebuild,v 1.1 2013/03/04 20:33:07 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Nova API"
HOMEPAGE="https://github.com/rackspace/rackspace-novaclient"
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
