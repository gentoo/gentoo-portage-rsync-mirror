# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_learn/scikits_learn-0.13.1.ebuild,v 1.3 2013/05/15 07:08:18 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
DISTUTILS_NO_PARALLEL_BUILD=true

inherit distutils-r1 multilib flag-o-matic

MYPN="${PN/scikits_/scikit-}"

DESCRIPTION="Python modules for machine learning and data mining"
HOMEPAGE="http://scikit-learn.org"
SRC_URI="mirror://sourceforge/${MYPN}/${MYPN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="
	sci-libs/scikits[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MYPN}-${PV}"

python_prepare_all() {
	# bug #397605
	[[ ${CHOST} == *-darwin* ]] \
		&& append-ldflags -bundle "-undefined dynamic_lookup" \
		|| append-ldflags -shared

	# scikits-learn now uses the horrible numpy.distutils automagic
	export SCIPY_FCONFIG="config_fc --noopt --noarch"
}

python_compile() {
	distutils-r1_python_compile ${SCIPY_FCONFIG}
}

python_compile_all() {
	if use doc; then
		cd "${S}/doc"
		local d="${BUILD_DIR}"/lib
		ln -s "${S}"/sklearn/datasets/{data,descr,images} \
			"${d}"/sklearn/datasets
		VARTEXFONTS="${T}"/fonts \
			MPLCONFIGDIR="${BUILD_DIR}" \
			PYTHONPATH="${d}" \
			emake html
		rm -r "${d}"/sklearn/datasets/{data,desr,images}
	fi
}

python_test() {
	# doc builds and runs tests
	use doc && return
	esetup.py \
		install --root="${T}/test-${EPYTHON}" \
		--no-compile ${SCIPY_FCONFIG} || die
	cd "${T}/test-${EPYTHON}/$(python_get_sitedir)" || die
	PYTHONPATH=. nosetests-${EPYTHON} sklearn --exe || die
}

python_install() {
	distutils-r1_python_install ${SCIPY_FCONFIG}
}

python_install_all() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils-r1_python_install_all
	insinto /usr/share/doc/${PF}
	use doc && dohtml -r doc/_build/html
	use examples && doins -r examples
}
