# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytables/pytables-2.4.0-r1.ebuild,v 1.1 2013/05/04 10:31:49 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

MY_PN=tables
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="A package for managing hierarchical datasets built on top of the HDF5 library"
HOMEPAGE="http://www.pytables.org http://pypi.python.org/pypi/tables"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.gz"

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

DOCS=( ANNOUNCE.txt RELEASE_NOTES.txt THANKS doc/usersguide-${PV}.pdf )

python_prepare_all() {
	export HDF5_DIR="${EPREFIX}"/usr
	distutils-r1_python_prepare_all
}

python_test() {
	${PYTHON} tables/tests/test_all.py || die
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
