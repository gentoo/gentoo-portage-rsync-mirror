# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snappy/snappy-0.5-r2.ebuild,v 1.1 2014/11/24 14:20:46 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

MY_PN=python-${PN}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python library for the snappy compression library from Google"
HOMEPAGE="http://pypi.python.org/pypi/python-snappy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND=">=app-arch/snappy-1.0.2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

python_test() {
	"${PYTHON}" test_snappy.py -v || die "Tests fail with ${EPYTHON}"
}
