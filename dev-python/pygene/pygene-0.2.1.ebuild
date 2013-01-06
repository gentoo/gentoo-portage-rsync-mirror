# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygene/pygene-0.2.1.ebuild,v 1.4 2010/07/08 18:37:19 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Simple python genetic algorithms programming library"
HOMEPAGE="http://www.freenet.org.nz/python/pygene/"
SRC_URI="http://www.freenet.org.nz/python/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="doc? ( >=dev-python/epydoc-2.1-r2 )"
RDEPEND="examples? ( >=dev-python/pyfltk-1.1.2 )"

DOCS="BUGS CREDITS INSTALL"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		epydoc -n "pygene - Python genetic algorithms" -o doc pygene || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo*.py salesman.gif || die "Installation of examples failed"
	fi
}
