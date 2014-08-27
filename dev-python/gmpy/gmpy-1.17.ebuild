# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gmpy/gmpy-1.17.ebuild,v 1.3 2014/08/27 12:06:13 blueness Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Python bindings for GMP library"
HOMEPAGE="http://www.aleax.it/gmpy.html http://code.google.com/p/gmpy/ http://pypi.python.org/pypi/gmpy"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86 ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}
	app-arch/unzip"

DOCS=( doc/gmpydoc.txt )
HTML_DOCS=(	doc/index.html )

python_test() {
	if $(python_is_python3); then
		pushd test3 > /dev/null
	else
		pushd test > /dev/null
	fi
	sed \
		-e 's:_test():_test(chat=True):g' \
		-i gmpy_test.py || die
	"${EPYTHON}" gmpy_test.py || return 1
	popd > /dev/null
}
