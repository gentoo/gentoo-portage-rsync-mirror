# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpmath/mpmath-0.16.ebuild,v 1.5 2012/06/20 21:05:06 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="py.test"

inherit distutils

DESCRIPTION="Python library for arbitrary-precision floating-point arithmetic"
HOMEPAGE="http://code.google.com/p/mpmath/ http://pypi.python.org/pypi/mpmath"
SRC_URI="
	http://mpmath.googlecode.com/files/${P}.tar.gz
	doc? ( http://mpmath.googlecode.com/files/${PN}-docsrc-${PV}.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux ~ppc-macos"
IUSE="doc examples gmp matplotlib"

RDEPEND="
	gmp? ( dev-python/gmpy )
	matplotlib? ( dev-python/matplotlib )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

DOCS="CHANGES"

src_prepare() {
	distutils_src_prepare

	# This test requires X
	rm ${PN}/tests/test_visualization.py
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd "${WORKDIR}/doc" > /dev/null
		PYTHONPATH="${S}/build-$(PYTHON -f --ABI)/lib" "$(PYTHON -f)" build.py || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	testing() {
		cd "${S}"/mpmath/tests
		PYTHONPATH="${S}/build-${PYTHON_ABI}/lib" "$(PYTHON)" runtests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd "${WORKDIR}/doc" > /dev/null
		dohtml -r build/* || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins "${WORKDIR}/demo/"*
	fi
}
