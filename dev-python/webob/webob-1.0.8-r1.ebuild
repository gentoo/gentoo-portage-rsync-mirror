# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webob/webob-1.0.8-r1.ebuild,v 1.2 2013/03/28 10:51:19 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN=WebOb
MY_P=${MY_PN}-${PV}

DESCRIPTION="WSGI request and response object"
HOMEPAGE="http://webob.org/ http://pypi.python.org/pypi/WebOb"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc" # test"

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
#	test? ( dev-python/nose[${PYTHON_USEDEP}]
#		dev-python/webtest[${PYTHON_USEDEP}] )"
RDEPEND=""

# Almost impossible to solve circ-dep with dev-python/webtest.
# (due to different PYTHON_COMPAT)
RESTRICT=test

S=${WORKDIR}/${MY_P}

python_compile_all() {
	if use doc; then
		"${PYTHON}" setup.py build_sphinx || die
	fi
}

python_test() {
	nosetests -w tests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( build/sphinx/html/. )
	distutils-r1_python_install_all
}
