# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/msgpack/msgpack-0.3.0.ebuild,v 1.1 2013/03/11 06:12:43 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

MY_PN="${PN}-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MessagePack (de)serializer for Python"
HOMEPAGE="http://msgpack.org http://pypi.python.org/pypi/msgpack-python/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/six[${PYTHON_USEDEP}] 
		dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests -P -w test || die "Tests fail with ${EPYTHON}"
}
