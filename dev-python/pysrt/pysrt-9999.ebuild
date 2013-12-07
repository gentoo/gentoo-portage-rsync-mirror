# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysrt/pysrt-9999.ebuild,v 1.1 2013/12/07 17:31:25 tomwij Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )
EGIT_REPO_URI="https://github.com/byroot/pysrt.git"

inherit distutils-r1 git-2

DESCRIPTION="A library used to edit or create SubRip files"
HOMEPAGE="https://github.com/byroot/pysrt https://pypi.python.org/pypi/pysrt"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-python/charade[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[coverage(+),${PYTHON_USEDEP}] )
"

python_test() {
	nosetests --with-coverage --cover-package=pysrt \
		|| die "Tests failed under ${EPYTHON}"
}

src_install() {
	rm -rf "${S}/tests" || die

	distutils-r1_src_install
}

python_install() {
	rm -rf "${BUILD_DIR}/lib/tests" || die

	distutils-r1_python_install
}
