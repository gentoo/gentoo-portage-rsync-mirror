# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysendfile/pysendfile-2.0.0.ebuild,v 1.1 2013/11/14 07:30:40 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

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
