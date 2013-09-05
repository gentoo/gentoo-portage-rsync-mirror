# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hglib/hglib-1.0.ebuild,v 1.3 2013/09/05 18:46:36 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 pypy2_0 )
PYTHON_REQ_USE="threads(+)"

MY_P="python-${P}"
MY_PN="python-${PN}"

inherit distutils-r1

DESCRIPTION="Library for using the Mercurial Command Server from Python"
HOMEPAGE="http://mercurial.selenic.com/"
SRC_URI="mirror://pypi/p/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND=">=dev-vcs/mercurial-2.4.2"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${PN}-0.3-tests.patch )

python_test() {
	if ! ${PYTHON} test.py; then
		die "Tests failed under ${EPYTHON}"
	fi
}

python_install_all() {
	use examples && local EXAMPLES=( examples/stats.py )
	distutils-r1_python_install_all
}
