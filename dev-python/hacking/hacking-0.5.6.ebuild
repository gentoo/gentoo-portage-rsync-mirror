# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hacking/hacking-0.5.6.ebuild,v 1.4 2014/03/30 12:45:45 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Nova API"
HOMEPAGE="https://github.com/openstack-dev/hacking"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1[${PYTHON_USEDEP}]
		>=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
		<dev-python/d2to1-0.3[${PYTHON_USEDEP}]"
RDEPEND="~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
		~dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
		~dev-python/flake8-2.0[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
