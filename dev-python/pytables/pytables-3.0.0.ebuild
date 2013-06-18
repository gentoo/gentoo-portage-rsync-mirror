# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytables/pytables-3.0.0.ebuild,v 1.1 2013/06/18 00:20:27 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_2,3_3} )

MY_PN=tables
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="Hierarchical datasets for Python"
HOMEPAGE="http://www.pytables.org/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD"
IUSE="doc contrib examples"

RDEPEND="
	sci-libs/hdf5:=
	>=dev-python/numpy-1.6.0
	dev-python/numexpr
	dev-libs/lzo:2
	app-arch/bzip2"
DEPEND="${RDEPEND}
	dev-python/cython"

S=${WORKDIR}/${MY_P}

DOCS=( ANNOUNCE.txt RELEASE_NOTES.txt THANKS )

python_prepare_all() {
	export HDF5_DIR="${EPREFIX}"/usr
	sed -i -e "s:/usr:${EPREFIX}/usr:g" setup.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	cd ${BUILD_DIR}/lib* || die
	${EPYTHON} tables/tests/test_all.py || die
}

python_install_all() {
	if use doc; then
		HTML_DOCS=( doc/html/. )
		DOCS+=( doc/scripts )
	fi
	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	if use contrib; then
		insinto /usr/share/${PF}
		doins -r contrib
	fi
}
