# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chameleon/chameleon-2.8.3-r1.ebuild,v 1.2 2012/05/20 15:39:02 floppym Exp $

EAPI=3

SUPPORT_PYTHON_ABIS=1
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="Chameleon"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast HTML/XML template compiler for Python"
HOMEPAGE="http://chameleon.repoze.org http://pypi.python.org/pypi/Chameleon"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake html || die "make html failed"
	fi
}

src_install() {
	distutils_src_install

	delete_tests_and_incompatible_modules() {
		rm -fr "${ED}$(python_get_sitedir)/chameleon/tests"

		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			rm -f "${ED}$(python_get_sitedir)/chameleon/"{benchmark.py,py25.py}
		fi

		if [[ $(python_get_version -l) == "2.5" ]]; then
			echo "raise SyntaxError" > \
				"${ED}$(python_get_sitedir -b)/chameleon/py26.py"
		fi
	}
	python_execute_function -q delete_tests_and_incompatible_modules

	if use doc; then
		pushd _build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
