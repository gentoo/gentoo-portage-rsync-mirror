# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urwid/urwid-1.1.1-r1.ebuild,v 1.2 2013/08/03 09:45:46 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} )
PYTHON_REQ_USE="ncurses"

inherit distutils-r1

DESCRIPTION="Urwid is a curses-based user interface library for Python"
HOMEPAGE="http://excess.org/urwid/ http://pypi.python.org/pypi/urwid"
SRC_URI="http://excess.org/urwid/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="doc examples test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/twisted-core )"

PATCHES=( "${FILESDIR}"/${PN}-1.1.0-sphinx.patch )

python_compile_all() {
	if use doc ; then
		if [[ ${EPYTHON} == python3* ]] ; then
			2to3 -nw --no-diffs docs/conf.py || die
		fi
		cd docs
		sphinx-build . _build/html || die
	fi
}

python_compile() {
	if [[ ${EPYTHON} == python2* ]] ; then
		local CFLAGS="${CFLAGS} -fno-strict-aliasing"
		export CFLAGS
	fi

	distutils-r1_python_compile
}

python_test() {
	esetup.py test
}

python_install_all() {
	use doc && dohtml -r docs/_build/html/*

	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
