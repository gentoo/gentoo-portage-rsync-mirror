# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-ldapdb/django-ldapdb-0.1.0_p20130712.ebuild,v 1.1 2013/07/16 04:20:58 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="an LDAP database backend for Django"
HOMEPAGE="http://opensource.bolloretelecom.eu/projects/django-ldapdb/"
SRC_URI="http://dev.gentoo.org/~idella4/tarballs/${P/0.1.0/0.2.0}.tar.gz -> ${P}.tar.gz"

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

python_prepare_all() {
	# Disable tests requiring connecting to ldap server,
	# until 'someone' figures how to set one in localhost
	sed -e 's:test_update:_&:' -e 's:test_get:_&:' -e 's:test_scope:_&:' \
		-e 's:test_values_list:_&:' -e 's:test_values:_&:' -e 's:test_slice:_&:' \
		-e 's:test_order_by:_&:' -e 's:test_ldap_filter:_&:' -e 's:test_delete:_&:' \
		-e 's:test_filter:_&:' -e 's:test_bulk_delete:_&:' -e 's:test_count:_&:' \
		-e 's:test_index:_&:' -e 's:test_user_list:_&:' -e 's:test_user_detail:_&:' \
		-e 's:test_user_delete:_&:' -e 's:test_group_list:_&:' \-e 's:test_group_detail:_&:' \
		-e 's:test_group_search:_&:' -e 's:test_group_add:_&:' -e 's:test_group_delete:_&:' \
		-i examples/tests.py || die

	distutils-r1_python_prepare_all
}

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
