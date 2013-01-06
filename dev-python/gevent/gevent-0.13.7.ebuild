# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gevent/gevent-0.13.7.ebuild,v 1.5 2012/07/17 02:10:30 vapier Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="A Python networking library that uses greenlet to provide synchronous API"
HOMEPAGE="http://pypi.python.org/pypi/gevent/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples"

RDEPEND="dev-libs/libevent
	dev-python/greenlet"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"
#	test? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite]
#			dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 ) )

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="AUTHORS changelog.rst"
RESTRICT="test" # long and lot's of failures

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
