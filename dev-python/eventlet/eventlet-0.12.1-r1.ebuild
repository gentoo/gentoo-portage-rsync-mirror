# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eventlet/eventlet-0.12.1-r1.ebuild,v 1.1 2013/02/12 12:22:20 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Highly concurrent networking library"
HOMEPAGE="http://pypi.python.org/pypi/eventlet"
SRC_URI="mirror://pypi/e/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/greenlet"
DEPEND="doc? ( dev-python/sphinx )
	test? ( ${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C doc html
}

src_test() {
	# Tests bind to static addresses, bug #456920
	local DISTUTILS_NO_PARALLEL_BUILD=1

	distutils-r1_src_test
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )
	distutils-r1_python_install_all

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
