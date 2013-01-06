# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/virtualenv/virtualenv-1.8.2.ebuild,v 1.1 2012/09/29 23:11:31 radhermit Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils vcs-snapshot eutils

DESCRIPTION="Virtual Python Environment builder"
HOMEPAGE="http://www.virtualenv.org/ http://pypi.python.org/pypi/virtualenv"
SRC_URI="https://github.com/pypa/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
SLOT="0"
IUSE="doc"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? ( dev-python/mock )"

DOCS="docs/index.txt docs/news.txt"
PYTHON_MODNAME="virtualenv.py virtualenv_support"

src_prepare() {
	distutils_src_prepare

	# let the python eclass handle script versioning
	epatch "${FILESDIR}"/${P}-no-versioned-script.patch
}

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/_build/html/
}
