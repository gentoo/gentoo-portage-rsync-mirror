# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysendfile/pysendfile-2.0.0.ebuild,v 1.2 2014/03/31 20:24:55 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="A python interface to sendfile(2) system call"
HOMEPAGE="http://code.google.com/p/pysendfile/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
#	"${PYTHON}" test/test_sendfile.py || die "tests failed under ${EPYTHON}"
	nosetests test/test_sendfile.py || die "tests failed under ${EPYTHON}"
}
