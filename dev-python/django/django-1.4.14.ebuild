# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django/django-1.4.14.ebuild,v 1.3 2014/09/02 07:35:08 ago Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='sqlite?'

inherit bash-completion-r1 distutils-r1 versionator webapp

MY_P="Django-${PV}"

DESCRIPTION="High-level Python web framework"
HOMEPAGE="http://www.djangoproject.com/ http://pypi.python.org/pypi/Django"
SRC_URI="https://www.djangoproject.com/m/releases/$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="mysql postgres sqlite test"

RDEPEND="virtual/python-imaging[${PYTHON_USEDEP}]
	postgres? ( dev-python/psycopg:2[${PYTHON_USEDEP}] )
	mysql? ( >=dev-python/mysql-python-1.2.3[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	test? ( ${PYTHON_DEPS//sqlite?/sqlite} )"

S="${WORKDIR}/${MY_P}"

WEBAPP_MANUAL_SLOT="yes"

python_prepare_all() {
	# Disable tests requiring network connection.
	sed \
		-e "s/test_correct_url_value_passes/_&/" \
		-e "s/test_correct_url_with_redirect/_&/" \
		-i tests/modeltests/validation/tests.py || die
	sed \
		-e "s/test_urlfield_3/_&/" \
		-e "s/test_urlfield_4/_&/" \
		-e "s/test_urlfield_10/_&/" \
		-i tests/regressiontests/forms/tests/fields.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	# Tests have non-standard assumptions about PYTHONPATH,
	# and don't work with ${BUILD_DIR}/lib.
	PYTHONPATH=. \
	"${PYTHON}" tests/runtests.py --settings=test_sqlite -v1 \
		|| die "Tests fail with ${EPYTHON}"
}

src_test() {
	# Port conflict in django.test.testcases.LiveServerTestCase.
	# Several other races with temp files.
	DISTUTILS_NO_PARALLEL_BUILD=1 distutils-r1_src_test
}

src_install() {
	distutils-r1_src_install
	webapp_src_install
}

python_install_all() {
	distutils-r1_python_install_all

	newbashcomp extras/django_bash_completion ${PN}

	insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	doins -r django/contrib/admin/static/admin/.
}

pkg_postinst() {
	elog "A copy of the admin media is available to"
	elog "webapp-config for installation in a webroot,"
	elog "as well as the traditional location in python's"
	elog "site-packages dir for easy development"
	elog
	ewarn "If you build Django ${PV} without USE=\"vhosts\""

	# XXX: call webapp_pkg_postinst? the old ebuild didn't do that...
	ewarn "webapp-config will automatically install the"
	ewarn "admin media into the localhost webroot."
}
