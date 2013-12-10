# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-subunit/python-subunit-0.0.15.ebuild,v 1.1 2013/12/10 11:17:26 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="A streaming protocol for test results for python only"
HOMEPAGE="https://launchpad.net/subunit http://pypi.python.org/pypi/python-subunit"
SRC_URI="http://launchpad.net/subunit/trunk/${PV}/+download/subunit-${PV}.tar.gz -> ${P}.tar.gz"
#SRC_URI="mirror://pypi/p/python-${PN}/python-${P}.tar.gz"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86 ~x86-fbsd"
#need to keyword the following in =dev-python/extras-0.0.3 then readd the keywords here
#ia64 s390 sh sparc amd64-fbsd
IUSE=""
S="${WORKDIR}/subunit-${PV}"

RDEPEND=">=dev-python/testtools-0.9.30[${PYTHON_USEDEP}]
		dev-python/extras[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]
		!dev-python/subunit[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" all_tests.py || die
}
