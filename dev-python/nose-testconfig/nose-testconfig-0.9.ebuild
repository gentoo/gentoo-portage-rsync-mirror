# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose-testconfig/nose-testconfig-0.9.ebuild,v 1.1 2013/11/14 13:47:04 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0  )

inherit distutils-r1

DESCRIPTION="Test Configuration plugin for nosetests"
HOMEPAGE="http://bitbucket.org/jnoller/nose-testconfig"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="examples"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/nose"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DOCS=( docs/index.txt )

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
