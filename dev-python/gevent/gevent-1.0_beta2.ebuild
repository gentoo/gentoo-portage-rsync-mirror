# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gevent/gevent-1.0_beta2.ebuild,v 1.3 2012/07/17 02:10:30 vapier Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 3.* 2.7-pypy-* *-jython"
PYTHON_USE_WITH="ssl"
#2.5 needs http://pypi.python.org/pypi/ssl

inherit distutils

MY_PV=${PV/_beta/b}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Python networking library that uses greenlet to provide synchronous API"
HOMEPAGE="http://code.google.com/p/gevent/ http://pypi.python.org/pypi/gevent/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples"

RDEPEND="dev-libs/libev
	net-dns/c-ares
	dev-python/greenlet"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="AUTHORS changelog.rst TODO README.rst"
RESTRICT="test" # long and few failures

S=${WORKDIR}/${MY_P}

src_prepare() {
	distutils_src_prepare
	rm -rf {libev,c-ares}
}

src_compile() {
	distutils_src_compile
	if use doc; then
		PYTHONPATH="$(ls -d ${S}/build-$(PYTHON -f --ABI)/lib.*)" emake html -C	doc
	fi
}

src_test() {
	pushd greentest &> /dev/null
	testing() {
		PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" testrunner.py
	}
	python_execute_function testing
	popd &> /dev/null
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/_build/html/
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
