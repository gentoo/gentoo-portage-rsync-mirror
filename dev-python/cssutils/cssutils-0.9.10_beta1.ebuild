# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.10_beta1.ebuild,v 1.2 2012/09/12 23:10:41 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS=""
DISTUTILS_SRC_TEST="nosetests"
PYTHON_TESTS_RESTRICTED_ABIS="3.*"

inherit distutils

MY_P="${P/_beta/b}"

DESCRIPTION="A CSS Cascading Style Sheets library"
HOMEPAGE="http://pypi.python.org/pypi/cssutils/ https://bitbucket.org/cthedot/cssutils"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples test"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	app-arch/unzip
	test? ( dev-python/mock )"

PYTHON_MODNAME="cssutils encutils"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# Disable test failing with dev-python/pyxml installed.
	if has_version dev-python/pyxml; then
		sed -e "s/test_linecol/_&/" -i src/tests/test_errorhandler.py
	fi
}

src_install() {
	distutils_src_install

	# Don't install tests.
	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/tests"
	}
	python_execute_function -q delete_tests

	# Don't install py3 stuff on py2. Breaks py25
	deletion_of_unneeded_files() {
		[[ "${PYTHON_ABI}" == 3.* ]] && return
		rm -f "${ED}$(python_get_sitedir)/cssutils/_codec3.py"
	}
	python_execute_function -q deletion_of_unneeded_files

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
