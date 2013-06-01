# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-registration/django-registration-0.8-r2.ebuild,v 1.1 2013/06/01 13:20:52 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An extensible user-registration application for Django"
HOMEPAGE="http://www.bitbucket.org/ubernostrum/django-registration/wiki/ http://pypi.python.org/pypi/django-registration"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz https://github.com/nathanborror/django-registration/archive/master.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-python/django[${PYTHON_USEDEP}]
	app-arch/unzip
	test? ( <=dev-python/django-1.4.5[$(python_gen_usedep python{2_6,2_7})] )"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

python_prepare_all() {
	if use test; then
		DISTUTILS_IN_SOURCE_BUILD=1
		mv "${WORKDIR}"/${PN}-master/${PN#django-}/templates/ "${S}"/${PN#django-}/ || die
		# Disable invalid test
		sed -e 's:test_get_version:_&:' -i ${PN#django-}/tests/__init__.py || die
	fi
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use test; then
		# Acquire a settings.py
		django-admin.py-${EPYTHON} startproject regtest || die
		sed -e "/^INSTALLED_APPS/a\    'registration'," \
			-e 's/\(django.db.backends.\)/\1sqlite3/' \
			-e "s/\(NAME': '\)/\1test.db/" \
			-i regtest/regtest/settings.py || die "sed failed"
		echo "SKIP_REGISTRATION_TESTS=False" >> regtest/regtest/settings.py
		cd regtest || die
		ln -fs ../registration/urls.py . && cd .. || die
		touch regtest/__init__.py || die
		cp ${PN#django-}/templates/${PN#django-}/base_registration.html \
			${PN#django-}/templates/${PN#django-}/test_template_name.html || die
		cp regtest/regtest/settings.py registration/ || die
	fi
}

python_test() {
	# NOTE: tests pass in py2.6 only if run alone
	pushd "${BUILD_DIR}"/../ &> /dev/null
	PYTHONPATH=. django-admin.py-"${EPYTHON}" test --setting=registration.settings registration || die "tests failed"
}
