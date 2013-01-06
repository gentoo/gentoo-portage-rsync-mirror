# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyamg/pyamg-2.0.4.ebuild,v 1.3 2012/12/19 16:55:37 bicatali Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils eutils

DESCRIPTION="Algebraic multigrid solvers in Python"
HOMEPAGE="http://code.google.com/p/pyamg/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RESTRICT="test" # quite buggy

RDEPEND="sci-libs/scipy"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? ( dev-python/nose )"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.7.patch
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cd "${S}/Docs"
		PYTHONPATH=$(ls -d "${S}"/build-$(PYTHON -f --ABI)/lib*) emake html
	fi
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py \
			build -b "build-${PYTHON_ABI}" \
			install --home="${S}/test-${PYTHON_ABI}"
		pushd "${S}/test-${PYTHON_ABI}/lib/python" > /dev/null
		PYTHONPATH=. "$(PYTHON)" -c "import pyamg; pyamg.test()" 2>&1 | tee test.log
		grep -Eq "^(ERROR|FAIL):" test.log && return 1
		popd > /dev/null
		rm -fr test-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r Docs/build/html/*
}
