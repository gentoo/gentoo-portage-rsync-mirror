# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrypy/cherrypy-3.2.2-r1.ebuild,v 1.7 2013/09/05 18:46:16 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy2_0 )

inherit distutils-r1

MY_P="CherryPy-${PV}"

DESCRIPTION="CherryPy is a pythonic, object-oriented HTTP framework"
HOMEPAGE="http://www.cherrypy.org/ http://pypi.python.org/pypi/CherryPy"
SRC_URI="http://download.cherrypy.org/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ia64 ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests < /dev/tty || die "Testing failed with ${EPYTHON}"
}
