# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testify/testify-0.3.6.ebuild,v 1.1 2014/08/28 16:46:43 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy )
#RESTRICT="test" 	# basically very broken

inherit distutils-r1 vcs-snapshot

DESCRIPTION="A more pythonic replacement for the unittest module and nose"
HOMEPAGE="https://github.com/Yelp/testify http://pypi.python.org/pypi/testify/"
SRC_URI="https://github.com/Yelp/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )"
# There is another undocumented dep req'd for the testsuite; catbox
DOCS="README.md"

python_prepare_all() {
	# Correct typo in setup.py
	sed -e 's:mock,:mock:' -i setup.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	# https://github.com/Yelp/Testify/issues/283
	 "${PYTHON}" bin/${PN} test || die
}
