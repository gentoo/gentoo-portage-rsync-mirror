# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydns/pydns-3.0.2-r1.ebuild,v 1.10 2015/04/08 08:05:12 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Python module for DNS (Domain Name Service)"
HOMEPAGE="http://pydns.sourceforge.net/ http://pypi.python.org/pypi/pydns"
SRC_URI="http://downloads.sourceforge.net/project/pydns/py3dns/${P/py/py3}.tar.gz"

LICENSE="CNRI"
SLOT="3"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE="examples"

DEPEND="virtual/libiconv"
#should this have !dev-python/pydns:0 ?
RDEPEND=""

# Funny a dns package attempts to use the network on tests
# Await the day that gentoo chills out on such a blanket law.
RESTRICT=test

S="${WORKDIR}/${P/py/py3}"

python_test() {
	local test
	for test in tests/{test.py,test[2-5].py,testsrv.py}
	do
		"${PYTHON}" ${test} || die
	done
}

python_install_all() {
	use examples && local EXAMPLES=( ./{tests,tools}/. )
	distutils-r1_python_install_all
}
