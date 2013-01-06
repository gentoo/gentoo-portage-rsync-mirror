# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/msgpack/msgpack-0.2.1.ebuild,v 1.2 2012/08/27 15:59:48 floppym Exp $

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

DEPEND="test? ( dev-python/six )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_test() {
	distutils_src_test -P -w test;
}
