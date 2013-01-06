# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sphinx/sphinx-1.1.3-r2.ebuild,v 1.3 2012/05/01 12:00:37 xarthisius Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"
PYTHON_TESTS_RESTRICTED_ABIS="2.5 *-pypy-*"

inherit distutils

MY_PN="Sphinx"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python documentation generator"
HOMEPAGE="http://sphinx.pocoo.org/ http://pypi.python.org/pypi/Sphinx"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc latex"

DEPEND=">=dev-python/docutils-0.7
	>=dev-python/jinja-2.3
	>=dev-python/pygments-1.2
	dev-python/setuptools
	latex? (
		dev-texlive/texlive-latexextra
		app-text/dvipng
	)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_prepare() {
	distutils_src_prepare

	prepare_tests() {
		mkdir -p build-${PYTHON_ABI}
		cp -r tests build-${PYTHON_ABI}/tests
		if [[ $(python_get_version -l --major) == "3" ]]; then
			2to3-${PYTHON_ABI} -nw --no-diffs build-${PYTHON_ABI}/tests
		fi
	}
	use test && python_execute_function prepare_tests
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		sed -e "/import sys/a sys.path.insert(0, '${S}/build-$(PYTHON -f --ABI)/lib')" -i sphinx-build.py
		pushd doc > /dev/null
		emake SPHINXBUILD="$(PYTHON -f) ../sphinx-build.py" html || die
		popd > /dev/null
	fi
}

src_test() {
	testing() {
		pushd build-${PYTHON_ABI} > /dev/null
		echo PYTHONPATH=lib nosetests --verbosity=1
		PYTHONPATH=lib nosetests --verbosity=1
		local rv=$?
		popd > /dev/null
		return $rv
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	python_generate_wrapper_scripts -E -f -q "${ED}usr/bin/sphinx-build"

	delete_grammar_pickle() {
		rm -f "${ED}$(python_get_sitedir)/sphinx/pycode/Grammar$(python_get_version -l).pickle"
	}
	python_execute_function -q delete_grammar_pickle

	if use doc; then
		dohtml -A txt -r doc/_build/html/* || die "Installation of documentation failed"
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	# Generate the Grammar pickle to avoid sandbox violations.
	generation_of_grammar_pickle() {
		"$(PYTHON)" -c "import sys; sys.path.insert(0, '${EROOT}$(python_get_sitedir -b)'); from sphinx.pycode.pgen2.driver import load_grammar; load_grammar('${EROOT}$(python_get_sitedir -b)/sphinx/pycode/Grammar.txt')"
	}
	python_execute_function \
		--action-message 'Generation of Grammar pickle with $(python_get_implementation_and_version)...' \
		--failure-message 'Generation of Grammar pickle with $(python_get_implementation_and_version) failed' \
		generation_of_grammar_pickle
}

pkg_postrm() {
	distutils_pkg_postrm

	deletion_of_grammar_pickle() {
		rm -f "${EROOT}$(python_get_sitedir -b)/sphinx/pycode"/Grammar*.pickle || return 1

		# Delete empty parent directories.
		local dir="${EROOT}$(python_get_sitedir -b)/sphinx/pycode"
		while [[ "${dir}" != "${EROOT%/}" ]]; do
			rmdir "${dir}" 2> /dev/null || break
			dir="${dir%/*}"
		done
	}
	python_execute_function \
		--action-message 'Deletion of Grammar pickle with $(python_get_implementation_and_version)...' \
		--failure-message 'Deletion of Grammar pickle with $(python_get_implementation_and_version) failed' \
		deletion_of_grammar_pickle
}
