# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testify/testify-0.2.6.ebuild,v 1.2 2012/05/20 13:16:37 klausman Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
# TODO: verify 2.5
RESTRICT_PYTHON_ABIS="2.5 3.* 2.7-pypy-*"

inherit eutils distutils vcs-snapshot

DESCRIPTION="A more pythonic replacement for the unittest module and nose"
HOMEPAGE="https://github.com/Yelp/testify http://pypi.python.org/pypi/testify/"
SRC_URI="https://github.com/Yelp/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/pyyaml
	dev-python/sqlalchemy
	www-servers/tornado
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 dev-python/simplejson )"
DEPEND="dev-python/setuptools
	test? ( ${RDEPEND} )"

#DOCS="README.txt"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${P}-tests.patch
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib/"  "$(PYTHON)" bin/${PN} test
	}
	python_execute_function testing
}
