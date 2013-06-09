# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sympy/sympy-0.7.2-r1.ebuild,v 1.3 2013/06/09 17:38:33 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2} )
inherit distutils-r1 eutils
DESCRIPTION="Computer algebra system (CAS) in Python"
HOMEPAGE="http://sympy.org/"
SRC_URI="python_targets_python2_6? ( http://sympy.googlecode.com/files/${P}.tar.gz )
	python_targets_python2_7? ( http://sympy.googlecode.com/files/${P}.tar.gz )
	python_targets_python3_2? ( http://sympy.googlecode.com/files/${P}-py3.2.tar.gz )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-macos"
IUSE="doc examples gtk imaging ipython latex mathml opengl pdf png pyglet system-mpmath test texmacs"

RDEPEND="
	mathml? (
		dev-libs/libxml2:2[python]
		dev-libs/libxslt[python]
		gtk? ( x11-libs/gtkmathview[gtk] ) )
	latex? (
		virtual/latex-base
		dev-texlive/texlive-fontsextra
		png? ( app-text/dvipng )
		pdf? ( app-text/ghostscript-gpl ) )
	texmacs? ( app-office/texmacs )
	ipython? ( dev-python/ipython[${PYTHON_USEDEP}] )
	opengl? ( dev-python/pyopengl[python_targets_python2_6?,python_targets_python2_7?] )
	imaging? ( virtual/python-imaging[${PYTHON_USEDEP}] )
	pyglet? ( dev-python/pyglet[python_targets_python2_6?,python_targets_python2_7?] )
	>=dev-python/pexpect-2.0[python_targets_python2_6?,python_targets_python2_7?]
	system-mpmath? ( ~dev-python/mpmath-0.17[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}"

system_mpmath() {
	local MPMATH_FILES
	MPMATH_FILES="sympy/combinatorics/permutations.py \
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
		rm -rf sympy/mpmath/*
		sed -e "s:sympy\.mpmath:mpmath:g" \
			-e "s:from sympy import mpmath:import mpmath:g" \
			-i ${MPMATH_FILES} || die "failed to patch mpmath imports"
		epatch "${FILESDIR}"/${P}-mpmath.patch
}

src_unpack() {
	if use python_targets_python2_6 || use python_targets_python2_7; then
		mkdir "${WORKDIR}"/python2
		cd "${WORKDIR}"/python2
		unpack ${P}.tar.gz
	fi
	if use python_targets_python3_2; then
		mkdir "${WORKDIR}"/python3
		cd "${WORKDIR}"/python3
		unpack ${P}-py3.2.tar.gz
	fi
}

src_prepare() {
	if use system-mpmath; then
		if use python_targets_python2_6 || use python_targets_python2_7; then
			cd "${WORKDIR}"/python2/${P}
			system_mpmath
		fi
		if use python_targets_python3_2; then
			cd "${WORKDIR}"/python3/${P}
			system_mpmath
		fi
	fi
}

python_compile() {
	case ${EPYTHON} in
		python2*) cd "${WORKDIR}"/python2/${P};;
		python3*) cd "${WORKDIR}"/python3/${P};;
	esac
	PYTHONPATH="." distutils-r1_python_compile
}

python_compile_all() {
	if use doc; then
		if use python_targets_python2_6 || use python_targets_python2_7; then
			cd "${WORKDIR}"/python2/${P}/doc
			emake html
		else
			cd "${WORKDIR}"/python3/${P}/doc
			emake html
		fi
	fi
}

python_test() {
	case ${EPYTHON} in
		python2*) cd "${WORKDIR}"/python2/${P};;
		python3*) cd "${WORKDIR}"/python3/${P};;
	esac
	PYTHONPATH="." py.test || ewarn "tests with ${EPYTHON} failed"
}

python_install() {
	case ${EPYTHON} in
		python2*) cd "${WORKDIR}"/python2/${P};;
		python3*) cd "${WORKDIR}"/python3/${P};;
	esac
	PYTHONPATH="." distutils-r1_python_install
}

python_install_all() {
	if use python_targets_python2_6 || use python_targets_python2_7; then
		cd "${WORKDIR}"/python2/${P}
	else
		cd "${WORKDIR}"/python3/${P}
	fi
	if use doc; then
		dohtml -r doc/_build/html/*
	fi
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
