# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hglib/hglib-0.9.ebuild,v 1.1 2013/06/18 14:02:06 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 pypy{1_9,2_0} )
PYTHON_USE_WITH="python_targets_python2_7? ( threads )"

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

RDEPEND=">=dev-vcs/mercurial-1.9"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${PN}-0.3-tests.patch )

python_test() {
	#  http://bz.selenic.com/show_bug.cgi?id=3965
	if ! ${PYTHON} test.py; then
		die "Tests failed under ${EPYTHON}"
	fi
}

python_install_all() {
	use examples && local EXAMPLES=( examples/stats.py )
	distutils-r1_python_install_all
}
