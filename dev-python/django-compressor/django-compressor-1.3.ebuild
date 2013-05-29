# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-compressor/django-compressor-1.3.ebuild,v 1.1 2013/05/29 11:54:23 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN="${PN/-/_}"
DESCRIPTION="Allows to define regrouped/postcompiled content 'on the fly' inside of django template"
HOMEPAGE="http://pypi.python.org/pypi/django_compressor/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

LICENSE="MIT"
SLOT="0"

S=${WORKDIR}/${MY_PN}-${PV}

RDEPEND=">=dev-python/django-1.1.4[${PYTHON_USEDEP}]
	>=dev-python/django-appconf-0.4[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND} dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/versiontools[${PYTHON_USEDEP}]
	test? ( dev-python/twill[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	export SECRET_KEY="green"
	local test
	for test in compressor/tests/test_*.py
	do
		if "${PYTHON}" -c \
			"from django.conf import global_settings;global_settings.SECRET_KEY='$SECRET_KEY'" ${test}
		then
			einfo "Test ${test} completed under ${EPYTHON}"
		else
			die "${test} failed with Python ${EPYTHON}"
		fi
	done
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
