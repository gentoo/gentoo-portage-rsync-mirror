# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/restkit/restkit-4.2.1-r1.ebuild,v 1.11 2015/04/08 08:04:53 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

DESCRIPTION="A HTTP ressource kit for Python"
HOMEPAGE="http://github.com/benoitc/restkit http://benoitc.github.com/restkit/ http://pypi.python.org/pypi/restkit"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="+cli doc examples test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx
		dev-python/epydoc )
	test? ( dev-python/webob
		>=dev-python/socketpool-0.5.0
		>=dev-python/http-parser-0.7.7 )"
RDEPEND="cli? ( dev-python/ipython
	dev-python/setuptools[${PYTHON_USEDEP}] )
	dev-python/webob
	>=dev-python/socketpool-0.5.0
	>=dev-python/http-parser-0.7.7"

PATCHES=( "${FILESDIR}/${PN}-exclude-tests.patch" )

python_compile_all() {
	if use doc ; then
		pushd doc > /dev/null
		PYTHONPATH="${S}" emake html
		popd > /dev/null
	fi
}

python_test() {
	nosetests -v tests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use cli || rm "${ED}"/usr/bin/restcli*

	use doc && dohtml -r doc/_build/html/
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
	distutils-r1_python_install_all
}
