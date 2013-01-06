# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webtest/webtest-1.3.4.ebuild,v 1.5 2012/10/13 19:00:10 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.1"
PYTHON_TESTS_RESTRICTED_ABIS="*-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

MY_PN="WebTest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper to test WSGI applications"
HOMEPAGE="http://pythonpaste.org/webtest/ http://pypi.python.org/pypi/WebTest"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=dev-python/webob-0.9.2"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/pyquery )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-index_fixt.patch"
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		sphinx-build docs html || die "Building of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	# Avoid future-import bug on py2.5.* - lint3 is py3 anyway
	delete_lint3() {
		[[ "${PYTHON_ABI}" == 3.* ]] && return
		rm "${ED}$(python_get_sitedir)/webtest/lint3.py"
	}
	python_execute_function -q delete_lint3

	if use doc; then
		dohtml -r html/*
	fi
}
