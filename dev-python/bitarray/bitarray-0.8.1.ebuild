# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bitarray/bitarray-0.8.1.ebuild,v 1.4 2015/03/08 23:40:22 pacho Exp $

EAPI=5
PYTHON_COMPAT=(python{2_{6,7},3_{2,3,4}})

inherit distutils-r1

DESCRIPTION="efficient arrays of booleans -- C extension"
HOMEPAGE="https://github.com/ilanschnell/bitarray http://pypi.python.org/pypi/bitarray"
SRC_URI="mirror://pypi/b/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="PSF-2"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"

python_test() {
	"${PYTHON}" ${PN}/test_${PN}.py || die "Tests fail with ${EPYTHON}"
}
