# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/configobj/configobj-4.7.2.ebuild,v 1.8 2011/03/04 20:55:40 xarthisius Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Simple config file reader and writer"
HOMEPAGE="http://www.voidspace.org.uk/python/configobj.html http://code.google.com/p/configobj/ http://pypi.python.org/pypi/configobj"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc"

DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="configobj.py validate.py"

src_prepare() {
	epatch "${FILESDIR}/${PN}-4.7.2-fix_tests.patch"
	sed -e "s/ \(doctest\.testmod(.*\)/ sys.exit(\1[0] != 0)/" -i validate.py
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" validate.py -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		rm -f docs/BSD*
		insinto /usr/share/doc/${PF}/html
		doins -r docs/* || die "doins failed"
	fi
}
