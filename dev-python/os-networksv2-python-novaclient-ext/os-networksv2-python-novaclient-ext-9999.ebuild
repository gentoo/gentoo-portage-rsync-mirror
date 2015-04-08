# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/os-networksv2-python-novaclient-ext/os-networksv2-python-novaclient-ext-9999.ebuild,v 1.2 2013/05/03 18:47:37 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/rackspace/os_networksv2_python_novaclient_ext.git
	https://github.com/rackspace/os_networksv2_python_novaclient_ext.git"

DESCRIPTION="Adds network extension support to python-novaclient"
HOMEPAGE="https://github.com/rackspace/os_networksv2_python_novaclient_ext"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

S="${WORKDIR}/os_networksv2_python_novaclient_ext-${PV}"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/python-novaclient-2.10.0[${PYTHON_USEDEP}]"
