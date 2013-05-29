# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-tastypie/django-tastypie-0.9.15.ebuild,v 1.1 2013/05/29 07:56:40 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A flexible and capable API layer for django utilising serialisers"
HOMEPAGE="http://pypi.python.org/pypi/django-tastypie/ https://github.com/toastdriven/django-tastypie"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="bip doc digest lxml oauth test yaml"

LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-python/mimeparse-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-1.5[${PYTHON_USEDEP}]
	!=dev-python/python-dateutil-2.0
	dev-python/django[${PYTHON_USEDEP}]
	bip? ( dev-python/biplist[${PYTHON_USEDEP}] )
	digest? ( dev-python/python-digest[${PYTHON_USEDEP}] )
	oauth? ( dev-python/oauth2[${PYTHON_USEDEP}] dev-python/django-oauth-plus[${PYTHON_USEDEP}] )
	lxml? ( dev-python/lxml[${PYTHON_USEDEP}] )
	yaml? ( dev-python/pyyaml[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND} >=dev-python/django-1.2.5[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mock[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	export SECRET_KEY='green'
	if ! "${PYTHON}" -c \
		"from django.conf import global_settings;global_settings.SECRET_KEY='$SECRET_KEY'" \
		-m tastypie.test; then
		die "test ${test} failed under ${EPYTHON}"
	else
		einfo "test ${test} passed under ${EPYTHON}"
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
