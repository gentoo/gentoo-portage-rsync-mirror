# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/subunit/subunit-0.0.15.ebuild,v 1.8 2015/01/04 15:41:15 dilfridge Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit autotools-utils python-r1

DESCRIPTION="A streaming protocol for test results"
HOMEPAGE="https://launchpad.net/subunit http://pypi.python.org/pypi/python-subunit"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"
#SRC_URI="mirror://pypi/p/python-${PN}/python-${P}.tar.gz"
#S="${WORKDIR}/python-${P}"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~x86 ~x86-fbsd"
#need to keyword the following in =dev-python/extras-0.0.3 then readd the keywords here
#ia64 s390 sh sparc amd64-fbsd
IUSE=""

RDEPEND=">=dev-python/testtools-0.9.30[${PYTHON_USEDEP}]
		dev-python/extras[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]
		dev-lang/perl:=
		dev-libs/check
		dev-util/cppunit
		>=sys-devel/automake-1.12
		virtual/pkgconfig"

python_test() {
	"${PYTHON}" runtests.py || die
}
