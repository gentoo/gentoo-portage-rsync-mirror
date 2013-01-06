# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparsing/pyparsing-1.5.5.ebuild,v 1.15 2012/03/31 17:26:00 armin76 Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="pyparsing is an easy-to-use Python module for text parsing"
HOMEPAGE="http://pyparsing.wikispaces.com/ http://pypi.python.org/pypi/pyparsing"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
PYTHON_MODNAME="pyparsing.py"

src_install() {
	distutils_src_install

	dohtml HowToUsePyparsing.html
	dodoc CHANGES

	if use doc; then
		dohtml -r htmldoc/*
		insinto /usr/share/doc/${PF}
		doins docs/*.pdf
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
