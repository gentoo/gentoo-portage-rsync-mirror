# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/virtualenv/virtualenv-1.7.1.2-r1.ebuild,v 1.6 2012/09/29 23:13:34 radhermit Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Virtual Python Environment builder"
HOMEPAGE="http://www.virtualenv.org/ http://pypi.python.org/pypi/virtualenv"
SRC_URI="https://github.com/pypa/${PN}/tarball/${PV} -> ${P}-new.tar.gz"

LICENSE="MIT"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
SLOT="0"
IUSE="doc"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
		doc? ( dev-python/sphinx )
		test? ( dev-python/mock )"

DOCS="docs/index.txt docs/news.txt"
PYTHON_MODNAME="virtualenv.py virtualenv_support"

src_unpack() {
	unpack ${A}
	mv pypa-virtualenv-* ${P}
}

src_prepare() {
	distutils_src_prepare
	# Disable broken test
	sed -e 's/test_version/_&/' -i tests/test_virtualenv.py
}

src_compile() {
	distutils_src_compile
	if use doc; then
		pushd docs > /dev/null
		emake html
		popd > /dev/null
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
