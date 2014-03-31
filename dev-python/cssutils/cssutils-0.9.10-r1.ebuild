# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.10-r1.ebuild,v 1.3 2014/03/31 21:01:05 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="A CSS Cascading Style Sheets library"
HOMEPAGE="http://pypi.python.org/pypi/cssutils/ https://bitbucket.org/cthedot/cssutils"
# Missing test data
# https://bitbucket.org/cthedot/cssutils/pull-request/11
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"
HG_COMMIT="6fbc1877f6089610b733a92d21c2bbf25dc1ca28"
SRC_URI="https://bitbucket.org/cthedot/cssutils/get/${HG_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/mock[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Disable test failing with dev-python/pyxml installed.
	if has_version dev-python/pyxml; then
		sed -e "s/test_linecol/_&/" -i src/tests/test_errorhandler.py
	fi

	distutils-r1_python_prepare_all
}

python_test() {
	ln -s "${S}/sheets" "${BUILD_DIR}/sheets" || die
	set --  nosetests -P "${BUILD_DIR}/lib/cssutils/tests"
	echo "$@"
	"$@" || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
