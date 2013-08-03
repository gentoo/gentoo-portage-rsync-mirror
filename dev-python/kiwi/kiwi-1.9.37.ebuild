# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kiwi/kiwi-1.9.37.ebuild,v 1.2 2013/08/03 09:45:42 mgorny Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython *-pypy-*"

inherit distutils versionator virtualx

DESCRIPTION="Kiwi is a pure Python framework and set of enhanced PyGTK widgets"
HOMEPAGE="http://www.async.com.br/projects/kiwi/
	https://launchpad.net/kiwi
	http://pypi.python.org/pypi/kiwi-gtk"
MY_PN="${PN}-gtk"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="examples test"

RDEPEND="dev-python/pygtk"
DEPEND="${RDEPEND}
	test? (
		dev-python/pep8
		dev-python/pyflakes
		dev-python/twisted-core
	)
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare
	sed -e "s:share/doc/kiwi:share/doc/${PF}:g" -i setup.py || die "sed failed"
}

src_test() {
	# Tarballs are missing files.
	# https://code.launchpad.net/~floppym/kiwi/testfiles/+merge/106505
	rm tests/test_ui.py tests/test_Delegate.py

	testing() {
		"$(PYTHON)" tests/run_all_tests.py
	}
	VIRTUALX_COMMAND=python_execute_function virtualmake testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
