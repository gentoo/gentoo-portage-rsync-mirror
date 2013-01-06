# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_image/scikits_image-0.7.2-r1.ebuild,v 1.2 2013/01/03 20:40:40 bicatali Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"
PYTHON_MODNAME="skimage"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MYPN="${PN/scikits_/scikit-}"

DESCRIPTION="Image processing routines for SciPy"
HOMEPAGE="http://scikit-image.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${MYPN}/${MYPN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="freeimage gtk qt4 test"

RDEPEND="
	sci-libs/scikits
	sci-libs/scipy
	freeimage? ( media-libs/freeimage )
	gtk? ( dev-python/pygtk )
	qt4? ( dev-python/PyQt4 )"
DEPEND="
	>=dev-python/cython-0.15
	>=dev-python/numpy-1.6
	dev-python/setuptools
	test? ( dev-python/matplotlib )"

# missing data files to generate doc in version 0.7.2
#	doc? ( dev-python/matplotlib
#		   dev-python/sphinx
#		   media-libs/freeimage
#		   sci-libs/scipy
#		   dev-python/sphinx )"

S="${WORKDIR}/${MYPN}-${PV}"

DOCS="*.txt"

src_test() {
	testing() {
		"$(PYTHON)" setup.py \
			build -b build-${PYTHON_ABI} \
			install --root="${T}/test-${PYTHON_ABI}" \
			--no-compile || die "install test failed"
		pushd "${T}/test-${PYTHON_ABI}${EPREFIX}$(python_get_sitedir)" \
			> /dev/null || die
		echo "backend: Agg" > matplotlibrc
		MPLCONFIGDIR=. PYTHONPATH=. nosetests-${PYTHON_ABI}
		popd > /dev/null
		rm -fr test-${PYTHON_ABI}
	}
	python_execute_function testing
}
