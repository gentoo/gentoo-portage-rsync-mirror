# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/billiard/billiard-2.7.3.28.ebuild,v 1.1 2013/04/22 08:31:28 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Python multiprocessing fork"
HOMEPAGE="http://pypi.python.org/pypi/billiard https://github.com/celery/billiard"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	nosetests || die
}
