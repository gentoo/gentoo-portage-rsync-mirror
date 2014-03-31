# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chameleon/chameleon-2.14.ebuild,v 1.2 2014/03/31 20:42:27 mgorny Exp $

EAPI=5

# py2.6 requires ordereddict that's not packaged for Gentoo
PYTHON_COMPAT=( python{2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

MY_PN="Chameleon"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast HTML/XML template compiler for Python"
HOMEPAGE="http://chameleon.repoze.org http://pypi.python.org/pypi/Chameleon"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_compile_all() {
	use doc && emake html
}

python_test() {
	esetup.py test
}

python_install_all() {
	use doc && local HTML_DOCS=( _build/html/{[a-z]*,_static} )

	distutils-r1_python_install_all
}
