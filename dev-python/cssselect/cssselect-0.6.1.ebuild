# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssselect/cssselect-0.6.1.ebuild,v 1.8 2012/10/13 17:34:14 armin76 Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="parses CSS3 Selectors and translates them to XPath 1.0"
HOMEPAGE="http://packages.python.org/cssselect/ http://pypi.python.org/pypi/cssselect"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/lxml )"
RDEPEND=""

DOCS="AUTHORS CHANGES README.rst"

src_compile() {
	distutils_src_compile
	if use doc ; then
		"$(PYTHON -f)" setup.py build_sphinx || die
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" ${PN}/tests.py -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc ; then
		dohtml -r docs/_build/html/
	fi
}
