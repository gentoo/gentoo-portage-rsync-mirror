# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-debug-toolbar/django-debug-toolbar-0.11.0.ebuild,v 1.2 2014/03/03 11:00:45 ultrabug Exp $

EAPI=5

# Keep py2.6 for now
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A configurable set of panels that display debug information"
HOMEPAGE="http://pypi.python.org/pypi/django-debug-toolbar/
	https://github.com/django-debug-toolbar/django-debug-toolbar/"
SRC_URI="https://github.com/django-debug-toolbar/django-debug-toolbar/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

LICENSE="MIT"
SLOT="0"
DISTUTILS_IN_SOURCE_BUILD=1

RDEPEND=">=dev-python/django-1.4.2[${PYTHON_USEDEP}]
		<dev-python/django-1.7[${PYTHON_USEDEP}]
		>=dev-python/python-sqlparse-0.1.10[$(python_gen_usedep python2_7 'python3*')]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -e 's:intersphinx_mapping:_&:' -i docs/conf.py || die

	# tests folder in this versions invokes file collision on install
	if ! use test; then
		rm -rf tests || die
	fi
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	# python-sqlparse-0.1.10 doesn't support py2_6
	if [[ "${EPYTHON}" != "python2.6" ]]; then
		emake test
	fi
	# tests folder in this versions invokes file collision on install
	rm -rf ./{build/lib/tests,tests}/ || die
}

python_install() {
	distutils-r1_python_install
	#rm all OSX fork files, Bug #450880
	pushd "${ED}" > /dev/null
	rm -f $(find . -name "._*")
}

python_install() {
	rm -rf "${S}"/tests/  || die
	distutils-r1_python_install
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	use examples && local EXAMPLES=( example/. )
	distutils-r1_python_install_all
}
