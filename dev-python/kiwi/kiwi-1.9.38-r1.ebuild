# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kiwi/kiwi-1.9.38-r1.ebuild,v 1.1 2013/07/05 04:44:09 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 versionator virtualx

DESCRIPTION="Kiwi is a pure Python framework and set of enhanced PyGTK widgets"
HOMEPAGE="http://www.async.com.br/projects/kiwi/
	https://launchpad.net/kiwi
	http://pypi.python.org/pypi/kiwi-gtk"
MY_PN="${PN}-gtk"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="examples test"

RDEPEND=">=dev-python/pygtk-2.24[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -e "s:share/doc/kiwi:share/doc/${PF}:g" -i setup.py || die "sed failed"
	distutils-r1_python_prepare_all
}

# Just in case
python_test() {
	# Tarballs are missing files.
	# https://code.launchpad.net/~floppym/kiwi/testfiles/+merge/106505
	rm tests/{test_pyflakes.py,test_pep8.py,test_ui.py}

	pushd "${BUILD_DIR}"/../ > /dev/null
	testing() {
		PYTHONPATH="${PYTHONPATH}":tests "${PYTHON}" tests/run_all_tests.py
	}
	VIRTUALX_COMMAND=virtualmake testing
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
	rmdir "${D}"usr/share/doc/${PF}/{api,howto} || die
}
