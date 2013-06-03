# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/south/south-0.8.1.ebuild,v 1.2 2013/06/03 04:22:41 dev-zero Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit vcs-snapshot distutils-r1

DESCRIPTION="Intelligent schema migrations for Django apps."
HOMEPAGE="http://south.aeracode.org/"
SRC_URI="https://bitbucket.org/andrewgodwin/south/get/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx dev-python/jinja )
	test? ( dev-python/django[sqlite] )"

# we are setting up the tests, but they fail

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
}

python_compile() {
	distutils-r1_python_compile
	if use test; then
		cd "${BUILD_DIR}"
		django-admin.py startproject southtest || die "setting up test env failed"
		cd southtest
		sed -i \
			-e "/^INSTALLED_APPS/a\    'south'," \
			-e 's/\(django.db.backends.\)/\1sqlite3/' \
			-e "s/\(NAME': '\)/\1test.db/" \
			southtest/settings.py || die "sed failed"
		echo "SKIP_SOUTH_TESTS=False" >> southtest/settings.py
	fi
}

python_test() {
	# http://south.aeracode.org/ticket/1256
	cd "${BUILD_DIR}/southtest"
	"${EPYTHON}" manage.py test south || die "tests failed for ${EPYTHON}"
}

pkg_postinst() {
	elog "In order to use the south schema migrations for your Django project,"
	elog "just add 'south' to your INSTALLED_APPS in the settings.py file."
	elog "manage.py will now automagically offer the new functions."
}
