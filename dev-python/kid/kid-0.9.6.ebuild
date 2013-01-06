# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kid/kid-0.9.6.ebuild,v 1.4 2010/04/04 16:24:31 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A simple and Pythonic XML template language"
HOMEPAGE="http://www.kid-templating.org/ http://pypi.python.org/pypi/kid"
SRC_URI="http://www.kid-templating.org/dist/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc examples"

RDEPEND=""
DEPEND="dev-python/setuptools
	doc? ( dev-python/docutils )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="HISTORY RELEASING"

src_compile() {
	distutils_src_compile
	use doc && emake -C doc
}

src_test() {
	testing() {
		PYTHONPATH="." "$(PYTHON)" run_tests.py -x
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	dobin bin/*

	dodoc doc/*.txt
	use doc && dohtml doc/*.{html,css}

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
