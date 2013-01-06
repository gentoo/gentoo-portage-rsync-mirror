# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/south/south-0.7.5.ebuild,v 1.4 2012/12/16 13:58:41 ago Exp $

EAPI="4"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils

DESCRIPTION="Intelligent schema migrations for Django apps."
HOMEPAGE="http://south.aeracode.org/"
SRC_URI="https://bitbucket.org/andrewgodwin/south/get/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx dev-python/jinja )"

# we are setting up the tests, but they fail
RESTRICT="test"

src_unpack() {
	default
	mv "${WORKDIR}"/*-south-* "${S}"
}

src_compile() {
	distutils_src_compile

	use doc && emake -C docs html
}

src_install() {
	distutils_src_install

	use doc && dohtml -r docs/_build/html/*
}

pkg_postinst() {
	distutils_pkg_postinst
	elog "In order to use the south schema migrations for your Django project,"
	elog "just add 'south' to your INSTALLED_APPS in the settings.py file."
	elog "manage.py will now automagically offer the new functions."
}

src_test() {
	testing() {
		mkdir -p "${T}/test-${PYTHON_ABI}"
		cd "${T}/test-${PYTHON_ABI}"

		django-admin.py-${PYTHON_ABI} startproject southtest || die "setting up test env failed"
		cd southtest
		sed -i \
			-e "/^INSTALLED_APPS/a\    'south'," \
			-e 's/\(django.db.backends.\)/\1sqlite3/' \
			-e "s/\(NAME': '\)/\1test.db/" \
			southtest/settings.py || die "sed failed"
		echo "SKIP_SOUTH_TESTS=False" >> southtest/settings.py
		PYTHONPATH="${S}/build-${PYTHON_ABI}/lib:${S}/south/tests" "$(PYTHON)" manage.py test south || die "tests failed"
	}
	python_execute_function testing
}
