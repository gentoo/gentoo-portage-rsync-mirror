# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-ldapdb/django-ldapdb-0.1.0_p20120424.ebuild,v 1.3 2012/05/20 11:54:44 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.* *-pypy-* *-jython"
inherit distutils

DESCRIPTION="an LDAP database backend for Django"
HOMEPAGE="http://opensource.bolloretelecom.eu/projects/django-ldapdb/"
SRC_URI="http://dev.gentoo.org/~tampakrap/tarballs/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="examples test"
LICENSE="MIT"
SLOT="0"
PYTHON_MODNAME="ldapdb"
S="${WORKDIR}/${PN}"

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/python-ldap )"

src_test() {
	# Exclude examples from test phase
	mv examples/tests.py examples/tests

	testing() {
		"$(PYTHON)" manage.py test
	}

	python_execute_function testing
	mv examples/tests examples/tests.py
}

src_install() {
	distutils_src_install
	samples() {
		insinto $(python_get_libdir)/site-packages/${PYTHON_MODNAME}/
		doins -r examples/
	}

	if use examples; then
		python_execute_function samples
	fi
}
