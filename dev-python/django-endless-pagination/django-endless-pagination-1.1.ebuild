# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-endless-pagination/django-endless-pagination-1.1.ebuild,v 1.1 2012/11/18 12:04:34 idella4 Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_TESTS_RESTRICTED_ABIS="2.7-pypy-1.*"
inherit distutils

DESCRIPTION="Tools supporting ajax, multiple and lazy pagination, Twitter-style and Digg-style pagination"
HOMEPAGE="http://code.google.com/p/django-endless-pagination/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
PYTHON_MODNAME="endless_pagination"

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
	doc? ( dev-python/sphinx )"

src_compile() {
	distutils_src_compile
	use doc && emake -C doc html
}

src_test() {
	testing() {
		pushd build-"${PYTHON_ABI}"/lib > /dev/null
		PYTHONPATH=. "$(PYTHON)" -d "${S}"/tests/runtests.py
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/_build/html/
}
