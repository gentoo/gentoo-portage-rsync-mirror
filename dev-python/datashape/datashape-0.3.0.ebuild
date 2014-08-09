# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/datashape/datashape-0.3.0.ebuild,v 1.1 2014/08/09 08:29:27 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Language defining a data description protocol"
HOMEPAGE="https://github.com/ContinuumIO/datashape"
SRC_URI="https://github.com/ContinuumIO/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/multipledispatch[${PYTHON_USEDEP}]
"
DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( ${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Prevent un-needed d'loading
	sed -e "s/'sphinx.ext.intersphinx', //" -i docs/source/conf.py || die
	distutils-r1_python_prepare_all

}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	# https://github.com/ContinuumIO/datashape/issues/78
	cd "${BUILD_DIR}"/lib* || die
	nosetests -v || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
