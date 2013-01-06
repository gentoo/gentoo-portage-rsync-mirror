# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tox/tox-1.4.2.ebuild,v 1.3 2012/10/31 08:56:59 mgorny Exp $

EAPI=4

PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="virtualenv-based automation of test activities"
HOMEPAGE="http://tox.testrun.org http://pypi.python.org/pypi/tox"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/setuptools
		>=dev-python/virtualenv-1.7
		dev-python/pip
		dev-python/pytest
		>=dev-python/py-1.4.9
		virtual/python-argparse
		doc? ( dev-python/sphinx )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-rm_version_test.patch
}

src_compile() {
	distutils_src_compile
	use doc && emake -C doc html
}

src_test() {
	testing() {
		PYTHONPATH=. py.test -x
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/_build/html/
}
