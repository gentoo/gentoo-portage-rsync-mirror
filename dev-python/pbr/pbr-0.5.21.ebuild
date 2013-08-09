# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pbr/pbr-0.5.21.ebuild,v 1.3 2013/08/09 16:18:26 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 python3_2 python3_3 )

inherit distutils-r1

DESCRIPTION="PBR is a library that injects some useful and sensible default
behaviors into your setuptools run."
HOMEPAGE="https://github.com/openstack-dev/pbr"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">dev-python/pip-1.0[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
