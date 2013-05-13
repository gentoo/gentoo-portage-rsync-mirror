# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/autopep8/autopep8-9999.ebuild,v 1.6 2013/05/13 18:32:56 xarthisius Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1 git-2

DESCRIPTION="Automatically formats Python code to conform to the PEP 8 style guide"
HOMEPAGE="https://github.com/hhatto/autopep8 http://pypi.python.org/pypi/autopep8"
SRC_URI=""
EGIT_REPO_URI="git://github.com/hhatto/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_test() {
	"${PYTHON}" setup.py test || die
}
