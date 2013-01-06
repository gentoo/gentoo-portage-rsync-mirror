# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/msgpack/msgpack-0.1.12.ebuild,v 1.4 2012/02/21 09:06:26 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5 3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7-pypy-* *-jython"
DISTUTILS_SRC_TEST="nosetests"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit distutils

MY_PN="${PN}-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MessagePack (de)serializer for Python"
HOMEPAGE="http://msgpack.org http://pypi.python.org/pypi/msgpack-python/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	preparation() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			rm -rf test || die
			mv test3 test || die
		else
			rm -rf test3 || die
		fi
	}
	python_execute_function -s preparation
}

src_test() {
	distutils_src_test -P -w test;
}
