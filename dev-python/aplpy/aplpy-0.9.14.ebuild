# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/aplpy/aplpy-0.9.14.ebuild,v 1.3 2014/11/28 10:00:53 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

MYPN=APLpy
MYP=${MYPN}-${PV}

DESCRIPTION="Astronomical Plotting Library in Python"
HOMEPAGE="http://aplpy.github.com/"
SRC_URI="mirror://pypi/${MYPN:0:1}/${MYPN}/${MYP}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pyavm[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MYP}

python_compile() {
	distutils-r1_python_compile --use-system-libraries --offline
}

python_test() {
	distutils_install_for_testing --offline
	cd "${TEST_DIR}" || die
	"${EPYTHON}" -c "import aplpy, sys;r = aplpy.test();sys.exit(r)" \
		|| die "tests fail with ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install --offline
}
