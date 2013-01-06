# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_learn/scikits_learn-0.12.1.ebuild,v 1.2 2012/12/10 18:32:50 bicatali Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-*"

inherit distutils multilib flag-o-matic

MYPN="${PN/scikits_/scikit-}"

DESCRIPTION="Python modules for machine learning and data mining"
HOMEPAGE="http://scikit-learn.org"
SRC_URI="mirror://sourceforge/${MYPN}/${MYPN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="
	sci-libs/scikits
	sci-libs/scipy
	dev-python/matplotlib"
DEPEND="
	dev-python/cython
	dev-python/setuptools
	sci-libs/scipy
	doc? ( dev-python/sphinx dev-python/matplotlib )"

S="${WORKDIR}/${MYPN}-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/0.12.1-linalg.patch

	# bug #397605
	[[ ${CHOST} == *-darwin* ]] \
		&& append-ldflags -bundle "-undefined dynamic_lookup" \
		|| append-ldflags -shared

	# scikits-learn now uses the horrible numpy.distutils automagic
	export SCIPY_FCONFIG="config_fc --noopt --noarch"
}

src_compile() {
	distutils_src_compile ${SCIPY_FCONFIG}
	if use doc; then
		cd "${S}/doc"
		local d=$(ls -d "${S}"/build-$(PYTHON -f --ABI)/lib*)
		ln -s "${S}"/sklearn/datasets/{data,descr,images} \
			"${d}"/sklearn/datasets
		VARTEXFONTS="${T}"/fonts \
			MPLCONFIGDIR="${S}/build-$(PYTHON -f --ABI)" \
			PYTHONPATH="${d}" \
			emake html
		rm -r "${d}"/sklearn/datasets/{data,desr,images}
	fi
}

src_test() {
	# doc builds and runs tests
	use doc && return
	testing() {
		"$(PYTHON)" setup.py build_ext --inplace ${SCIPY_FCONFIG} || die
		PYTHONPATH=. nosetests sklearn --exe || die
	}
	python_execute_function testing
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install ${SCIPY_FCONFIG}
	insinto /usr/share/doc/${PF}
	use doc && dohtml -r doc/_build/html
	use examples && doins -r examples
}
