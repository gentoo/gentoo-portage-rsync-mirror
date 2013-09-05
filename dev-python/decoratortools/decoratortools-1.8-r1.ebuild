# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/decoratortools/decoratortools-1.8-r1.ebuild,v 1.2 2013/09/05 18:47:07 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="DecoratorTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Class, function, and metaclass decorators"
HOMEPAGE="http://pypi.python.org/pypi/DecoratorTools"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="|| ( PSF-2 ZPL )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# Disable tests broken with named tuples.
	sed -e "s/additional_tests/_&/" -i test_decorators.py || die "sed failed"
}

python_test() {
	esetup.py test && einfo "Tests passed under ${EPYTHON}" || die "Tests failed under ${EPYTHON}"
}
