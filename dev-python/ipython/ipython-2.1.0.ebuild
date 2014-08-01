# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-2.1.0.ebuild,v 1.1 2014/08/01 03:25:26 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE='readline,sqlite'

inherit distutils-r1 elisp-common virtualx

DESCRIPTION="Advanced interactive shell for Python"
HOMEPAGE="http://ipython.org/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/rel-${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc examples matplotlib mongodb notebook nbconvert octave	qt4 +smp test wxwidgets"

PY2_USEDEP=$(python_gen_usedep python2_7)
gen_python_deps() {
	local flag
	for flag in $(python_gen_useflags '*'); do
		echo "${flag}? ( ${1}[${flag}(-)] )"
	done
}

CDEPEND="
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/simplegeneric[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	matplotlib? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
	mongodb? ( dev-python/pymongo[${PYTHON_USEDEP}] )
	octave? ( dev-python/oct2py[${PYTHON_USEDEP}] )
	smp? ( dev-python/pyzmq[${PYTHON_USEDEP}] )
	wxwidgets? ( dev-python/wxpython[${PY2_USEDEP}] )"
RDEPEND="${CDEPEND}
	notebook? (
		>=www-servers/tornado-2.1[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pyzmq[${PYTHON_USEDEP}]
		dev-libs/mathjax
		$(gen_python_deps dev-python/jinja)
	)
	nbconvert? (
		app-text/pandoc
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		$(gen_python_deps dev-python/jinja)
	)
	qt4? ( || ( dev-python/PyQt4[${PYTHON_USEDEP}] dev-python/pyside[${PYTHON_USEDEP}] )
			dev-python/pygments[${PYTHON_USEDEP}]
			dev-python/pyzmq[${PYTHON_USEDEP}] )"
DEPEND="${CDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/oct2py[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		net-libs/nodejs )"

PY2_REQUSE="$(python_gen_useflags python2_7)"
REQUIRED_USE="
	wxwidgets? ( ${PY2_REQUSE} )"

DISTUTILS_IN_SOURCE_BUILD=1

PATCHES=( "${FILESDIR}"/2.1.0-disable-tests.patch )

python_prepare_all() {
	# fix for gentoo python scripts
	sed -i \
		-e "/ipython_cmd/s/ipython3/ipython/g" \
		IPython/terminal/console/tests/test_console.py \
		IPython/testing/tools.py || die

	sed -i \
		-e "s/find_scripts(True, suffix='3')/find_scripts(True)/" \
		setup.py || die

	# fix gentoo installation directory for documentation
	sed -i \
		-e "/docdirbase  = pjoin/s/ipython/${PF}/" \
		-e "/pjoin(docdirbase,'manual')/s/manual/html/" \
		setupbase.py || die "sed failed"

	if ! use doc; then
		sed -i \
			-e "/(pjoin(docdirbase, 'extensions'), igridhelpfiles),/d" \
			-e 's/ + manual_files//' \
			setupbase.py || die
	fi

	if ! use examples; then
		sed -i \
			-e 's/+ example_files//' \
			setupbase.py || die
	fi

	if use doc; then
		# Prevent un-needed download during build
		sed -e "/^    'sphinx.ext.intersphinx',/d" -i docs/source/conf.py || die
	fi

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

src_test() {
	# virtualx has trouble with parallel runs.
	local DISTUTILS_NO_PARALLEL_BUILD=1
	distutils-r1_src_test
}

python_test() {
	distutils_install_for_testing
	local fail
	run_tests() {
		# Run tests (-v for more verbosity).
		PYTHONPATH="${PYTHONPATH}:$(pwd)"
		pushd ${TEST_DIR} > /dev/null
		"${PYTHON}" -c "import IPython; IPython.test()" || fail=1
		popd > /dev/null
	}

	VIRTUALX_COMMAND=run_tests virtualmake
}

python_install() {
	distutils-r1_python_install
	ln -snf "${EPREFIX}"/usr/share/mathjax \
		"${D}$(python_get_sitedir)"/IPython/html/static/mathjax || die

	# Create ipythonX.Y symlinks.
	# TODO:
	# 1. do we want them for pypy?
	# 2. handle it in the eclass instead (use _python_ln_rel).
	if [[ ${EPYTHON} == python* ]]; then
		dosym ../lib/python-exec/${EPYTHON}/ipython \
			/usr/bin/ipython${EPYTHON#python}
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
