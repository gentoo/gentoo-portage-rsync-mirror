# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-appconf/django-appconf-0.6.ebuild,v 1.2 2013/05/20 17:17:00 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A helper class for handling configuration defaults of packaged apps gracefully"
HOMEPAGE="http://pypi.python.org/pypi/django-appconf http://django-appconf.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-python/django-1.4.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/docs.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	export SECRET_KEY="green"
	pushd "${BUILD_DIR}"/lib > /dev/null
	if ! "${PYTHON}" -c \
		"from django.conf import global_settings;global_settings.SECRET_KEY='$SECRET_KEY'" \
		-m appconf.tests.tests
	then
		die "test failed under ${EPYTHON}"
	else
		einfo "tests passed under ${EPYTHON}"
	fi
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
