# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-pipeline/django-pipeline-1.3.9.ebuild,v 1.1 2013/05/17 13:37:03 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="http://pypi.python.org/pypi/django-pipeline/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/django-1.4.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/futures[$(python_gen_usedep python{2_6,2_7})] )"

python_compile_all() {
	use doc && emake -C docs html
	rm -f docs/_build/doctrees/environment.pickle || die
}

python_compile() {
	# Need remove tests before reaching distutils-r1_src_install
	if ! use test; then
		rm -rf tests/ || die
	fi
	distutils-r1_python_compile
}

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	local test
	pushd "${BUILD_DIR}"/lib/tests/tests/ > /dev/null || die
	for test in [a-z]*.py
	do
		if ! "${PYTHON}" -c \
			"from django.conf import global_settings;global_settings.SECRET_KEY='green'" ${test}
		then
			die "test ${test} failed under ${EPYTHON}"
		else
			einfo "test ${test} passed under ${EPYTHON}"
		fi
	done
	cd ../../
	rm -rf tests/ || die
	rm -rf "${S}"/tests/ || einfo "tests folder already removed"
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
