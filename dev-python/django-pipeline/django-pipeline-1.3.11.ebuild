# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-pipeline/django-pipeline-1.3.11.ebuild,v 1.1 2013/05/31 16:21:20 idella4 Exp $

EAPI=5
# There's doubt in py3.2's readiness
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="http://pypi.python.org/pypi/django-pipeline/ https://github.com/cyberdelia/django-pipeline"
SRC_URI="https://github.com/cyberdelia/django-pipeline/archive/1.3.11.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/django-1.4.1[${PYTHON_USEDEP}]
	dev-python/futures[$(python_gen_usedep python{2_6,2_7})]
	dev-python/jsmin[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare() {
	use test && DISTUTILS_IN_SOURCE_BUILD=1
	distutils_python_prepare
}

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
	pushd "${BUILD_DIR}"/lib/tests/ &> /dev/null
	ln -sf ../../../tests/assets . || die
	ln -sf ../../../tests/assets2 . || die
	cd ../../../ || die
	if ! django-admin.py-${EPYTHON} test --setting=tests.settings tests
	then
		die "Tests failed under ${EPYTHON}"
	else
		einfo "Tests passed under ${EPYTHON}"
	fi
	rm -rf tests/ || die
	rm -rf "${S}"/tests/ || einfo "tests folder already removed"
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
