# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chameleon/chameleon-2.11-r1.ebuild,v 1.1 2013/08/17 21:20:30 mgorny Exp $

EAPI=5

# py2.6 requires ordereddict that's not packaged for Gentoo
PYTHON_COMPAT=( python{2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

MY_PN="Chameleon"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast HTML/XML template compiler for Python"
HOMEPAGE="http://chameleon.repoze.org http://pypi.python.org/pypi/Chameleon"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# https://github.com/malthe/chameleon/commit/710e0dba76da2
	cat > MANIFEST.in <<_EOF_ || die
recursive-include src/chameleon/tests/inputs *
recursive-include src/chameleon/tests/outputs *
_EOF_

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake html
}

python_test() {
	esetup.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( _build/html/{[a-z]*,_static} )

	distutils-r1_python_install_all

#	delete_tests_and_incompatible_modules() {
#		rm -fr "${ED}$(python_get_sitedir)/chameleon/tests"
#
#		if [[ "$(python_get_version -l --major)" == "3" ]]; then
#			rm -f "${ED}$(python_get_sitedir)/chameleon/"{benchmark.py,py25.py}
#		fi
#
#		if [[ $(python_get_version -l) == "2.5" ]]; then
#			echo "raise SyntaxError" > \
#				"${ED}$(python_get_sitedir -b)/chameleon/py26.py"
#		fi
#	}
#	python_execute_function -q delete_tests_and_incompatible_modules
#
}
