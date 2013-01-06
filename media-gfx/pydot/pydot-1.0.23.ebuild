# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pydot/pydot-1.0.23.ebuild,v 1.11 2012/12/31 13:05:33 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Python interface to Graphviz's Dot language"
HOMEPAGE="http://code.google.com/p/pydot/ http://pypi.python.org/pypi/pydot"
SRC_URI="http://pydot.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="virtual/pyparsing
	media-gfx/graphviz"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="dot_parser.py pydot.py"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-setup.patch"
}
