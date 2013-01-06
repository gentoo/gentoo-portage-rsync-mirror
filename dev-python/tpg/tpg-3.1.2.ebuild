# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tpg/tpg-3.1.2.ebuild,v 1.2 2010/12/26 17:31:38 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_P="TPG-${PV}"

DESCRIPTION="Toy Parser Generator for Python"
HOMEPAGE="http://christophe.delord.free.fr/tpg/index.html"
SRC_URI="http://christophe.delord.free.fr/tpg/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="doc examples"

S="${WORKDIR}/${MY_P}"

DOCS="THANKS"
PYTHON_MODNAME="tpg.py"

src_test() {
	testing() {
		"$(PYTHON)" tpg_tests.py -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dodoc doc/tpg.pdf || die "dodoc failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "doins failed"
	fi
}
