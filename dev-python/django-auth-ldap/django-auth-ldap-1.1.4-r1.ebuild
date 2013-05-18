# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-auth-ldap/django-auth-ldap-1.1.4-r1.ebuild,v 1.1 2013/05/18 15:24:01 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Django LDAP authentication backend"
HOMEPAGE="http://pypi.python.org/pypi/django-auth-ldap http://bitbucket.org/psagers/django-auth-ldap/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="django_auth_ldap"

RDEPEND=">=dev-python/django-1.3.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/python-ldap[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/docs.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	if ! "${PYTHON}" -c \
		"from django.conf import global_settings;global_settings.SECRET_KEY='green'" -m django_auth_ldap.tests
	then
		die "tests failed under ${EPYTHON}"
	else
		einfo "tests passed under ${EPYTHON}"
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
