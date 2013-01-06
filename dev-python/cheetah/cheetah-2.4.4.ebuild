# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah/cheetah-2.4.4.ebuild,v 1.7 2011/08/29 21:47:22 neurogeek Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="Cheetah"
MY_P="${MY_PN}-${PV/_}"

DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/ http://rtyler.github.com/cheetah/ http://pypi.python.org/pypi/Cheetah"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
IUSE=""
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"

RDEPEND="dev-python/markdown"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES README.markdown TODO"
PYTHON_MODNAME="Cheetah"

src_prepare() {
	distutils_src_prepare

	# Disable broken tests.
	sed \
		-e "/Unicode/d" \
		-e "s/if not sys.platform.startswith('java'):/if False:/" \
		-e "/results =/a\\    sys.exit(not results.wasSuccessful())" \
		-i cheetah/Tests/Test.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" cheetah/Tests/Test.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/Cheetah/Tests"
	}
	python_execute_function -q delete_tests
}
