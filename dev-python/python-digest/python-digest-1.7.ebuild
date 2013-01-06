# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-digest/python-digest-1.7.ebuild,v 1.3 2012/05/04 08:07:21 iksaif Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="A Python library to aid in implementing HTTP Digest Authentication"
HOMEPAGE="http://pypi.python.org/pypi/python-digest/ https://bitbucket.org/akoha/python-digest/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="test"

LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="python_digest"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_prepare() {
	epatch "${FILESDIR}"/${P}-unittest.patch
	distutils_src_prepare
}

src_test() {
	testing() {
		 PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" \
		 	"$(PYTHON)" ${PYTHON_MODNAME}/tests.py
	}
	python_execute_function testing
}
