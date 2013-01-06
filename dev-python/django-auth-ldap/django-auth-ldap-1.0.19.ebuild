# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-auth-ldap/django-auth-ldap-1.0.19.ebuild,v 1.3 2012/05/04 08:07:57 iksaif Exp $

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

RDEPEND=""
DEPEND="${RDEPEND} >=dev-python/django-1.0
	dev-python/python-ldap
	doc? ( dev-python/sphinx )"

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	testing() {
		"$(PYTHON)" build-$(python_get_version)/lib/django_auth_ldap/tests.py
		echo "tests completed for python"$(python_get_version)
	}
	python_execute_function testing
}

src_compile() {
	distutils_src_compile
	if use doc; then
		emake -C docs html
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/*
	fi
}
