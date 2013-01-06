# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django/django-9999.ebuild,v 1.15 2012/11/01 07:56:06 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit bash-completion-r1 distutils subversion webapp

DESCRIPTION="High-level Python web framework"
HOMEPAGE="http://www.djangoproject.com/ http://pypi.python.org/pypi/Django"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc mysql postgres sqlite test"

RDEPEND="dev-python/imaging
	sqlite? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 ) )
	postgres? ( dev-python/psycopg )
	mysql? ( >=dev-python/mysql-python-1.2.1_p2 )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.3 )
	test? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 ) )"

S="${WORKDIR}"

ESVN_REPO_URI="http://code.djangoproject.com/svn/django/trunk/"

WEBAPP_MANUAL_SLOT="yes"

pkg_setup() {
	python_pkg_setup
	webapp_pkg_setup
}

src_prepare() {
	distutils_src_prepare

	# Disable tests requiring network connection.
	sed \
		-e "s/test_correct_url_value_passes/_&/" \
		-e "s/test_correct_url_with_redirect/_&/" \
		-i tests/modeltests/validation/tests.py
	sed \
		-e "s/test_urlfield_3/_&/" \
		-e "s/test_urlfield_4/_&/" \
		-e "s/test_urlfield_10/_&/" \
		-i tests/regressiontests/forms/tests/fields.py
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	testing() {
		# Tests have non-standard assumptions about PYTHONPATH and
		# don't work with usual "build-${PYTHON_ABI}/lib".
		PYTHONPATH="." "$(PYTHON)" tests/runtests.py --settings=test_sqlite -v1
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	newbashcomp extras/django_bash_completion ${PN} || die

	if use doc; then
		rm -fr docs/_build/html/_sources
		dohtml -A txt -r docs/_build/html/* || die "dohtml failed"
	fi

	insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	doins -r django/contrib/admin/static/admin/* || die "doins failed"
	webapp_src_install
}

pkg_preinst() {
	:
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo "Now, Django has the best of both worlds with Gentoo,"
	einfo "ease of deployment for production and development."
	echo
	elog "A copy of the admin media is available to"
	elog "webapp-config for installation in a webroot,"
	elog "as well as the traditional location in python's"
	elog "site-packages dir for easy development"
	echo
	ewarn "If you build Django ${PV} without USE=\"vhosts\""
	ewarn "webapp-config will automatically install the"
	ewarn "admin media into the localhost webroot."
}
