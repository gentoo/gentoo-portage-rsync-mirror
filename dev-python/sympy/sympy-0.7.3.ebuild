# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sympy/sympy-0.7.3.ebuild,v 1.3 2013/12/28 20:31:19 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1 eutils

DESCRIPTION="Computer algebra system (CAS) in Python"
HOMEPAGE="http://sympy.org/ https://github.com/sympy/sympy"
SRC_URI="
	python_targets_python2_6? ( https://github.com/${PN}/${PN}/releases/download/${P}/${P}.tar.gz )
	python_targets_python2_7? ( https://github.com/${PN}/${PN}/releases/download/${P}/${P}.tar.gz )
	python_targets_python3_2? ( https://github.com/${PN}/${PN}/releases/download/${P}/${P}-py3.2.tar.gz )
	python_targets_python3_3? ( https://github.com/${PN}/${PN}/releases/download/${P}/${P}-py3.2.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-macos"
IUSE="doc examples gtk imaging ipython latex mathml opengl pdf png pyglet system-mpmath test texmacs"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	mathml? (
		dev-libs/libxml2:2[${PYTHON_USEDEP}]
		dev-libs/libxslt[python_targets_python2_6?,python_targets_python2_7?]
		gtk? ( x11-libs/gtkmathview[gtk] ) )
	latex? (
		virtual/latex-base
		dev-texlive/texlive-fontsextra
		png? ( app-text/dvipng )
		pdf? ( app-text/ghostscript-gpl ) )
	texmacs? ( app-office/texmacs )
	ipython? ( dev-python/ipython[${PYTHON_USEDEP}] )
	opengl? ( dev-python/pyopengl[${PYTHON_USEDEP}] )
	imaging? ( virtual/python-imaging[${PYTHON_USEDEP}] )
	pyglet? ( dev-python/pyglet[python_targets_python2_6?,python_targets_python2_7?] )
	>=dev-python/pexpect-2.0[python_targets_python2_6?,python_targets_python2_7?]
	system-mpmath? ( ~dev-python/mpmath-0.17[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}"

system_mpmath() {
	local MPMATH_FILES
	MPMATH_FILES="
		sympy/combinatorics/permutations.py \
		sympy/core/containers.py \
		sympy/core/evalf.py \
		sympy/core/expr.py \
		sympy/core/function.py \
		sympy/core/numbers.py \
		sympy/core/power.py \
		sympy/core/sets.py \
		sympy/core/tests/test_evalf.py \
		sympy/core/tests/test_numbers.py \
		sympy/core/tests/test_sets.py \
		sympy/core/tests/test_sympify.py \
		sympy/external/tests/test_numpy.py \
		sympy/functions/combinatorial/numbers.py \
		sympy/functions/combinatorial/tests/test_comb_numbers.py \
		sympy/functions/special/bessel.py \
		sympy/functions/special/gamma_functions.py \
		sympy/functions/special/hyper.py \
		sympy/functions/special/tests/test_hyper.py \
		sympy/matrices/matrices.py \
		sympy/ntheory/partitions_.py \
		sympy/physics/quantum/constants.py \
		sympy/physics/quantum/qubit.py \
		sympy/plotting/experimental_lambdify.py \
		sympy/plotting/intervalmath/interval_arithmetic.py \
		sympy/polys/numberfields.py \
		sympy/polys/polytools.py \
		sympy/polys/rootoftools.py \
		sympy/polys/domains/__init__.py \
		sympy/polys/domains/algebraicfield.py \
		sympy/polys/domains/domain.py \
		sympy/polys/domains/expressiondomain.py \
		sympy/polys/domains/finitefield.py \
		sympy/polys/domains/fractionfield.py \
		sympy/polys/domains/gmpyintegerring.py \
		sympy/polys/domains/gmpyrationalfield.py \
		sympy/polys/domains/groundtypes.py \
		sympy/polys/domains/mpmathcomplexdomain.py \
		sympy/polys/domains/mpmathrealdomain.py \
		sympy/polys/domains/polynomialring.py \
		sympy/polys/domains/pythoncomplexdomain.py \
		sympy/polys/domains/pythonintegerring.py \
		sympy/polys/domains/pythonrationalfield.py \
		sympy/polys/domains/pythonrealdomain.py \
		sympy/polys/domains/quotientring.py \
		sympy/polys/domains/sympyintegerring.py \
		sympy/polys/domains/sympyrationalfield.py \
		sympy/polys/domains/sympyrealdomain.py \
		sympy/polys/tests/test_domains.py \
		sympy/printing/latex.py \
		sympy/printing/repr.py \
		sympy/printing/str.py \
		sympy/simplify/simplify.py \
		sympy/simplify/tests/test_hyperexpand.py \
		sympy/solvers/solvers.py \
		sympy/solvers/tests/test_numeric.py \
		sympy/statistics/distributions.py \
		sympy/statistics/tests/test_statistics.py \
		sympy/utilities/decorator.py \
		sympy/utilities/lambdify.py \
		sympy/utilities/runtests.py \
		sympy/utilities/tests/test_code_quality.py \
		sympy/utilities/tests/test_lambdify.py \
		examples/advanced/pidigits.py \
		examples/advanced/autowrap_ufuncify.py"
		rm -rf sympy/mpmath/* || die
		sed \
			-e "s:sympy\.mpmath:mpmath:g" \
			-e "s:from sympy import mpmath:import mpmath:g" \
			-i ${MPMATH_FILES} || die "failed to patch mpmath imports"
		epatch "${FILESDIR}"/${P}-mpmath.patch
}

python_unpack() {
	if ! python_is_python3; then
		mkdir "${WORKDIR}"/python2
		cd "${WORKDIR}"/python2 || die
		unpack ${P}.tar.gz
	fi
	if python_is_python3; then
		mkdir "${WORKDIR}"/python3
		cd "${WORKDIR}"/python3 || die
		unpack ${P}-py3.2.tar.gz
	fi
}

src_unpack() {
	python_foreach_impl python_unpack
}

python_prepare() {
	if use system-mpmath; then
		if ! python_is_python3; then
			cd "${WORKDIR}"/python2/${P} || die
			system_mpmath
		fi
		if python_is_python3; then
			cd "${WORKDIR}"/python3/${P} || die
			system_mpmath
		fi
	fi
}

src_prepare() {
	python_foreach_impl python_prepare
}

python_compile() {
	local _py
	if python_is_python3; then
		_py=3
	else
		_py=2
	fi

	cd "${WORKDIR}"/python${_py}/${P} || die
	export S="${WORKDIR}"/python${_py}/${P}

	PYTHONPATH="." distutils-r1_python_compile
}

python_compile_all() {
	local _py
	if use doc; then
		export XDG_CONFIG_HOME="${T}/config-dir"
		mkdir "${XDG_CONFIG_HOME}" || die
		chmod 0700 "${XDG_CONFIG_HOME}" || die
		if python_is_python3; then
			_py=3
		else
			_py=2
		fi

		cd "${WORKDIR}"/python${_py}/${P}/doc || die
		emake html

	fi
}

python_test() {
	local _py
	if python_is_python3; then
		_py=3
	else
		_py=2
	fi

	cd "${WORKDIR}"/python${_py}/${P} || die
	PYTHONPATH="." py.test || ewarn "tests with ${EPYTHON} failed"
}

python_install() {
	local _py
	if python_is_python3; then
		_py=3
	else
		_py=2
	fi

	cd "${WORKDIR}"/python${_py}/${P} || die
	export S="${WORKDIR}"/python${_py}/${P}

	PYTHONPATH="." distutils-r1_python_install
}

python_install_all() {
	local _py
	distutils-r1_python_install_all
	if python_is_python3; then
		_py=3
	else
		_py=2
	fi

	cd "${WORKDIR}"/python${_py}/${P} || die
	use doc && dohtml -r doc/_build/html/*

	if use examples; then
		insinto /usr/share/doc/${P}
		doins -r examples
	fi
	if use texmacs; then
		exeinto /usr/libexec/TeXmacs/bin/
		doexe data/TeXmacs/bin/tm_sympy
		insinto /usr/share/TeXmacs/plugins/sympy/
		doins -r data/TeXmacs/progs
	fi
}
