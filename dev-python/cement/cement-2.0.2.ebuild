# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cement/cement-2.0.2.ebuild,v 1.2 2013/05/10 04:28:52 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2} )

inherit distutils-r1 versionator

PV_MAJOR_MINOR=`get_version_component_range 1-2`

DESCRIPTION="CLI Application Framework for Python"
HOMEPAGE="http://builtoncement.com/"
SRC_URI="http://builtoncement.com/${PN}/${PV_MAJOR_MINOR}/source/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
	dev-python/coverage[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}
	virtual/python-argparse[${PYTHON_USEDEP}]"

DOCS=( ChangeLog CONTRIBUTORS README.md )
PATCHES=( "${FILESDIR}"/tests-installation.patch )
# https://github.com/cement/cement/issues/185

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_compile_all() {
	if use doc; then
		$PYTHON setup.py build_sphinx || die "couldn't build docs"
	fi
}

python_install_all() {
	use doc && HTML_DOCS=( doc/build/html/* )

	distutils-r1_python_install_all
}
