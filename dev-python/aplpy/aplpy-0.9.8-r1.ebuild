# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/aplpy/aplpy-0.9.8-r1.ebuild,v 1.1 2013/02/05 22:42:52 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

MYP=APLpy-${PV}

DESCRIPTION="Astronomical Plotting Library in Python"
HOMEPAGE="http://aplpy.github.com/"
SRC_URI="mirror://github/${PN}/${PN}/${MYP}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	dev-python/numpy
	dev-python/matplotlib
	dev-python/pyfits
	dev-python/pywcs"
DEPEND="
	dev-python/numpy
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		${RDEPEND}
	)"

S="${WORKDIR}/${MYP}"

python_test() {
	PYTHONPATH="${BUILD_DIR}"/lib "${EPYTHON}" runtests.py || die
}
