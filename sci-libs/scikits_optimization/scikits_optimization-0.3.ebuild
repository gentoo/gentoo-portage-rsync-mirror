# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_optimization/scikits_optimization-0.3.ebuild,v 1.2 2013/08/12 22:24:34 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

MY_P="${P/scikits_/scikits.}"

DESCRIPTION="Python module for numerical optimization"
HOMEPAGE="http://projects.scipy.org/scipy/scikits"
SRC_URI="mirror://pypi/${PN:0:1}/scikits.optimization/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-libs/scikits[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_test() {
	PYTHONPATH="${BUILD_DIR}/lib/" \
		esetup.py test || die
}
