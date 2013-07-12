# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-ldapdb/django-ldapdb-0.2.0_p20130712.ebuild,v 1.1 2013/07/12 16:16:07 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="an LDAP database backend for Django"
HOMEPAGE="http://opensource.bolloretelecom.eu/projects/django-ldapdb/"
SRC_URI="http://dev.gentoo.org/~idella4/tarballs/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="examples test"
LICENSE="MIT"
SLOT="0"
PYTHON_MODNAME="ldapdb"
S="${WORKDIR}"/${PN}
DISTUTILS_IN_SOURCE_BUILD=1

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/python-ldap[${PYTHON_USEDEP}] )"
RESTRICT="test"

python_compile() {
	distutils-r1_python_compile
	if use test; then
		pushd "${BUILD_DIR}"/lib > /dev/null
		django-admin.py startproject ldaptest || die "setting up test env failed"
		cp "${S}"/settings.py ldaptest/ldaptest/ || die
		sed -e "/^INSTALLED_APPS/a\    'ldapdb'," \
			-i ldaptest/ldaptest/settings.py || die "sed failed"
		echo "SKIP_SOUTH_TESTS=False" >> ldaptest/ldaptest/settings.py
		popd > /dev/null
	fi
}

python_test() {
	# https://github.com/jlaine/django-ldapdb/issues/2
	pushd build/lib/ > /dev/null
	ln -sf ../../examples . || die
	PYTHONPATH=${PYTHONPATH}:${PYTHONPATH}/ldaptest
	"${PYTHON}" ldaptest/manage.py test --settings=ldaptest.settings
	popd > /dev/null
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
