# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/colout/colout-0.1.ebuild,v 1.1 2013/06/06 15:12:47 zx2c4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )
inherit distutils-r1

DESCRIPTION="Adds color to arbitrary command output."
HOMEPAGE="http://nojhan.github.com/colout/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND="dev-python/pygments
	dev-python/Babel"

src_test() {
	testing() {
		PYTHONPATH="." "$(PYTHON)" run-tests.py
	}
	python_execute_function testing
}

src_install() {
	distutils-r1_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
