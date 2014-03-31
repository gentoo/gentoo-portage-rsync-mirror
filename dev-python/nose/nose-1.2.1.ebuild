# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose/nose-1.2.1.ebuild,v 1.7 2014/03/31 21:19:17 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy pypy2_0 )
inherit distutils-r1 eutils

DESCRIPTION="A unittest extension offering automatic test suite discovery and easy test authoring"
HOMEPAGE="http://pypi.python.org/pypi/nose http://readthedocs.org/docs/nose/ https://bitbucket.org/jpellerin/nose"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc examples test"

RDEPEND="dev-python/coverage[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )
	test? ( dev-python/twisted-core )"

DOCS=( AUTHORS )

python_prepare_all() {
	# Tests need to be converted, and they don't respect BUILD_DIR.
	use test && DISTUTILS_IN_SOURCE_BUILD=1

	# Disable sphinx.ext.intersphinx, requires network, rogue test
	epatch "${FILESDIR}/${PN}-0.11.0-disable_intersphinx.patch" \
		"${FILESDIR}"/${P}-skiptest.patch

	# Disable tests requiring network connection.
	sed \
		-e "s/test_resolve/_&/g" \
		-e "s/test_raises_bad_return/_&/g" \
		-e "s/test_raises_twisted_error/_&/g" \
		-i unit_tests/test_twisted.py || die "sed failed"
	# Disable versioning of nosetests script to avoid collision with
	# versioning performed by the eclass.
	sed -e "/'nosetests%s = nose:run_exit' % py_vers_tag,/d" \
		-i setup.py || die "sed2 failed"

	distutils-r1_python_prepare_all
}

python_compile() {
	local add_targets=()

	if use test; then
		add_targets+=( egg_info )
		[[ ${EPYTHON} == python3* ]] && add_targets+=( build_tests )
	fi

	distutils-r1_python_compile ${add_targets[@]}
}

python_compile_all() {
	use doc && emake -C doc html
}

src_test() {
	# nosetests use heavy multiprocessing during the tests.
	# this shall make them less likely to kill your system or timeout.
	local DISTUTILS_NO_PARALLEL_BUILD=1

	distutils-r1_src_test
}

python_test() {
	"${PYTHON}" selftest.py || die "Tests fail with ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install --install-data "${EPREFIX}/usr/share"
}

python_install_all() {
	if use doc; then
		dohtml -r -A txt doc/.build/html/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
