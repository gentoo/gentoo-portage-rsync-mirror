# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/six/six-9999.ebuild,v 1.11 2014/11/25 01:07:11 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy pypy3 )

#if LIVE
EHG_REPO_URI="https://bitbucket.org/gutworth/six"

inherit mercurial
#endif

inherit distutils-r1

DESCRIPTION="Python 2 and 3 compatibility library"
HOMEPAGE="https://bitbucket.org/gutworth/six http://pypi.python.org/pypi/six"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc test"

DEPEND="doc? ( dev-python/sphinx )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

#if LIVE
SRC_URI=
KEYWORDS=
#endif

python_compile_all() {
	use doc && emake -C documentation html
}

python_test() {
	py.test -v || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( documentation/_build/html/ )
	distutils-r1_python_install_all
}
