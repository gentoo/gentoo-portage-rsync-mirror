# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urwid/urwid-1.1.0.ebuild,v 1.6 2014/03/04 20:08:34 ago Exp $

EAPI="4"
PYTHON_USE_WITH="ncurses"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="3.1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

DESCRIPTION="Urwid is a curses-based user interface library for Python"
HOMEPAGE="http://excess.org/urwid/ http://pypi.python.org/pypi/urwid"
SRC_URI="http://excess.org/urwid/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc x86 ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="doc examples test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/twisted-core )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}"/${P}-sphinx.patch

	if [[ $(python_get_version -f --major) == 3 ]] ; then
		2to3-$(PYTHON -f --ABI) -nw --no-diffs docs/conf.py || die
	fi
}

src_compile() {
	distutils_src_compile

	if use doc ; then
		cd docs
		PYTHONPATH="$(ls -d ../build-$(PYTHON -f --ABI)/lib*)" sphinx-build . _build/html || die
	fi
}

src_install() {
	distutils_src_install

	use doc && dohtml -r docs/_build/html/*

	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
