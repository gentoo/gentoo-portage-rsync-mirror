# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/defusedxml/defusedxml-0.4.1.ebuild,v 1.5 2014/07/05 14:02:11 jer Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="XML bomb protection for Python stdlib modules, an xml serialiser"
HOMEPAGE="https://bitbucket.org/tiran/defusedxml"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="examples"

LICENSE="PSF-2"
SLOT="0"

RDEPEND="dev-python/pyxml[$(python_gen_usedep python{2_6,2_7})]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	esetup.py test || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( other/. )
	distutils-r1_python_install_all
}
