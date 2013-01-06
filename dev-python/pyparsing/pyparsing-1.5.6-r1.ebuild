# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparsing/pyparsing-1.5.6-r1.ebuild,v 1.1 2012/11/26 08:01:29 idella4 Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="pyparsing is an easy-to-use Python module for text parsing"
HOMEPAGE="http://pyparsing.wikispaces.com/ http://pypi.python.org/pypi/pyparsing"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd \
~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
PYTHON_MODNAME="pyparsing.py"

src_prepare() {
	# resorted to sed, fixed in June upstream, bug ID: 3381439. See Bug #443836. Unexplained delay of release of 1.5.7
	sed -e "s/26 June 2011 10:53/16 June 2012 03:08/" \
		-e 's:exc.__traceback__:pe.__traceback__:' \
		-i pyparsing_py3.py || die
	distutils_src_prepare
}

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
