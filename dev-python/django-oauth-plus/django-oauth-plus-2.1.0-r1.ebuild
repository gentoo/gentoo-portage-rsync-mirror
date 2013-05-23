# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-oauth-plus/django-oauth-plus-2.1.0-r1.ebuild,v 1.1 2013/05/23 17:52:07 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Support of OAuth 1.0a in Django using python-oauth2"
HOMEPAGE="http://pypi.python.org/pypi/django-oauth-plus	http://code.welldev.org/django-oauth-plus/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/django-1.2.4[${PYTHON_USEDEP}]
	>=dev-python/oauth2-1.5.170[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_hg[${PYTHON_USEDEP}]"

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	export SECRET_KEY='green'
	if "${PYTHON}" -c \
		"from django.conf import global_settings;global_settings.SECRET_KEY='$SECRET_KEY'" \
		-m oauth_provider.tests.tests; then
		einfo "Testsuite passed under ${EPYTHON}"
	else
		die "Testsuite failed under ${EPYTHON}"
	fi
}
