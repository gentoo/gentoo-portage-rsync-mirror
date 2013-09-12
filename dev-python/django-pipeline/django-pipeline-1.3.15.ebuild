# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-pipeline/django-pipeline-1.3.15.ebuild,v 1.2 2013/09/12 11:23:40 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="http://pypi.python.org/pypi/django-pipeline/ https://github.com/cyberdelia/django-pipeline"

# PyPi releases lack docs/ subdir:
# https://github.com/cyberdelia/django-pipeline/pull/254
SRC_URI="https://github.com/cyberdelia/django-pipeline/archive/${PV}.tar.gz -> ${P}-gh.tar.gz"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/django-1.4.1[${PYTHON_USEDEP}]
	dev-python/futures[$(python_gen_usedep python{2_6,2_7})]
	dev-python/jsmin[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )
	test? (
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	cp -r tests "${BUILD_DIR}"/ || die
	PYTHONPATH=${BUILD_DIR}:${PYTHONPATH} \
	django-admin.py test --settings=tests.settings tests \
		|| die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
