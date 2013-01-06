# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-auth-ldap/django-auth-ldap-1.1.ebuild,v 1.1 2012/05/19 13:47:56 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Django LDAP authentication backend"
HOMEPAGE="http://pypi.python.org/pypi/django-auth-ldap http://bitbucket.org/psagers/django-auth-ldap/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="django_auth_ldap"

RDEPEND=">=dev-python/django-1.0"
DEPEND="${RDEPEND}
	dev-python/python-ldap
	doc? ( dev-python/sphinx )"

src_compile() {
	distutils_src_compile

	use doc && emake -C docs html
}

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"

	# Python.[56] trigger a harmless deprecation warning
	testing() {
		"$(PYTHON)" -m django_auth_ldap.tests
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
