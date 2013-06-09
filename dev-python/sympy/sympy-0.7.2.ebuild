# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sympy/sympy-0.7.2.ebuild,v 1.2 2013/06/09 17:38:33 floppym Exp $

EAPI="3"

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython *-pypy-*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

DESCRIPTION="Computer algebra system (CAS) in Python"
HOMEPAGE="http://code.google.com/p/sympy/"
SRC_URI="http://sympy.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-macos"
IUSE="doc examples gtk imaging ipython latex mathml opengl pdf png pyglet test texmacs"

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
	ipython? ( dev-python/ipython )
	opengl? ( dev-python/pyopengl )
	imaging? ( virtual/python-imaging )
	pyglet? ( dev-python/pyglet )
	>=dev-python/pexpect-2.0
	~dev-python/mpmath-0.17"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? ( dev-python/pytest )"

pkg_setup() {
	python_pkg_setup
	export DOT_SAGE="${S}"
}

src_prepare() {
	# Remove mpmath
	rm -rf sympy/mpmath/*
	sed -i \
		-e "s:sympy\.mpmath:mpmath:g" \
		-e "s:from sympy import mpmath:import mpmath:g" \
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
		examples/advanced/autowrap_ufuncify.py \
		|| die "failed to patch mpmath imports"
	epatch "${FILESDIR}"/${P}-mpmath.patch
}

src_compile() {
	PYTHONPATH="." distutils_src_compile

	if use doc; then
		cd doc
		emake html || die "emake html failed"
	fi
}

src_install() {
	PYTHONPATH="." distutils_src_install

	rm -f "${ED}usr/bin/"{doctest,test} || die "rm doctest test failed"

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
