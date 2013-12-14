# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/babelfish/babelfish-9999.ebuild,v 1.1 2013/12/14 15:18:02 tomwij Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3} )
EGIT_REPO_URI="https://github.com/Diaoul/babelfish.git"

inherit distutils-r1 git-2

DESCRIPTION="Python library to work with countries and languages"
HOMEPAGE="https://github.com/Diaoul/babelfish https://pypi.python.org/pypi/babelfish"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

python_test() {
	esetup.py test
}
