# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/joblib/joblib-0.7.0d-r1.ebuild,v 1.1 2013/03/09 10:47:56 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Lightweight pipelining: using Python functions as pipeline jobs."
HOMEPAGE="https://github.com/joblib/joblib http://pypi.python.org/pypi/joblib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_test() {
	PYTHONPATH=.:${PN}/
	nosetests $(find "${BUILD_DIR}" -name tests) || die
}
