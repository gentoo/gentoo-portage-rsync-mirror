# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pypacker/pypacker-2.4.ebuild,v 1.1 2013/09/28 14:51:11 jer Exp $

EAPI="5"

PYTHON_COMPAT=( python{3_1,3_2,3_3} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Fast and simple packet creation and parsing library for Python"
HOMEPAGE="https://github.com/mike01/pypacker"
SRC_URI="https://github.com/mike01/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( AUTHORS CHANGES HACKING README.md )

python_test() {
	"${PYTHON}" tests/test_pypacker.py || die
}

python_install_all() {
	distutils-r1_python_install_all
	use examples && dodoc -r examples
}
