# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/stevedore/stevedore-0.8-r1.ebuild,v 1.1 2013/04/19 07:39:32 idella4 Exp $

EAPI=5

# pypy may not be required, but nor does it bring any harm
PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Manage dynamic plugins for Python applications"
HOMEPAGE="https://github.com/dreamhost/stevedore"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	nosetests || die
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dohtml -r docs/build/html/
}
