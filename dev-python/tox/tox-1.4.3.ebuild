# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tox/tox-1.4.3.ebuild,v 1.4 2014/02/03 10:18:40 jlec Exp $

EAPI=4

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7-pypy-*"
inherit distutils eutils

DESCRIPTION="virtualenv-based automation of test activities"
HOMEPAGE="http://tox.testrun.org http://pypi.python.org/pypi/tox"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="
	dev-python/setuptools
	>=dev-python/virtualenv-1.7
	dev-python/pip
	dev-python/pytest
	>=dev-python/py-1.4.9
	virtual/python-argparse"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4.2-rm_version_test.patch
}

src_compile() {
	distutils_src_compile
	use doc && emake -C doc html
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py build -b build-${PYTHON_ABI} \
			install --root "${T}/test-${PYTHON_ABI}"
		PATH="${T}/test-${PYTHON_ABI}/usr/bin:${PATH}" \
		PYTHONPATH="${T}/test-${PYTHON_ABI}/$(python_get_sitedir -b)" py.test -x
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/_build/html/
}
