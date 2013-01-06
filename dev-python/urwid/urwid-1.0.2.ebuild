# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urwid/urwid-1.0.2.ebuild,v 1.6 2012/11/05 22:10:00 radhermit Exp $

EAPI="4"
PYTHON_USE_WITH="ncurses"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="3.1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Urwid is a curses-based user interface library for Python"
HOMEPAGE="http://excess.org/urwid/ http://pypi.python.org/pypi/urwid"
SRC_URI="http://excess.org/urwid/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="examples test"

DEPEND="dev-python/setuptools
	test? ( dev-python/twisted )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_install() {
	distutils_src_install

	dohtml reference.html tutorial.html

	if use examples; then
		docinto examples
		dodoc bigtext.py browse.py calc.py dialog.py edit.py \
			fib.py graph.py input_test.py tour.py
	fi
}
