# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/virtualenv/virtualenv-1.10-r1.ebuild,v 1.6 2014/06/08 12:21:45 hattya Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Virtual Python Environment builder"
HOMEPAGE="http://www.virtualenv.org/ http://pypi.python.org/pypi/virtualenv"
SRC_URI="https://github.com/pypa/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
SLOT="0"
IUSE="doc test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

DOCS=( docs/index.rst docs/news.rst )
PATCHES=( "${FILESDIR}"/${PN}-1.8.2-no-versioned-script.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dohtml -r docs/_build/html/
}

python_test() {
	nosetests || die
}
