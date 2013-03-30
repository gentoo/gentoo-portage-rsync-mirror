# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django/django-1.5.ebuild,v 1.5 2013/03/30 13:21:39 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
PYTHON_REQ_USE='sqlite?'

inherit bash-completion-r1 distutils-r1 versionator webapp

MY_P="Django-${PV}"

DESCRIPTION="High-level Python web framework"
HOMEPAGE="http://www.djangoproject.com/ http://pypi.python.org/pypi/Django"
SRC_URI="https://www.djangoproject.com/m/releases/$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc mysql postgres sqlite test"

PY2_USEDEP=$(python_gen_usedep 'python2*')
RDEPEND="dev-python/imaging[${PY2_USEDEP}]
	postgres? ( dev-python/psycopg:2[${PYTHON_USEDEP}] )
	mysql? ( >=dev-python/mysql-python-1.2.3[${PY2_USEDEP}] )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-1.0.7[${PYTHON_USEDEP}] )
	test? ( ${PYTHON_DEPS//sqlite?/sqlite} )"

S="${WORKDIR}/${MY_P}"

WEBAPP_MANUAL_SLOT="yes"

python_compile_all() {
	use doc && emake -C docs html
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

python_install_all() {
	distutils-r1_python_install_all
	newbashcomp extras/django_bash_completion ${PN}

	if use doc; then
		rm -fr docs/_build/html/_sources
		dohtml -A txt -r docs/_build/html/.
	fi

	insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	doins -r django/contrib/admin/static/admin/.

	webapp_src_install
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
