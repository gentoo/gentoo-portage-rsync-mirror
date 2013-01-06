# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epydoc/epydoc-3.0.1-r1.ebuild,v 1.14 2012/04/26 17:38:39 aballier Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="X"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils eutils

DESCRIPTION="Tool for generating API documentation for Python modules, based on their docstrings"
HOMEPAGE="http://epydoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="doc latex X"

DEPEND=""
RDEPEND="dev-python/docutils
	latex? ( virtual/latex-base
			 dev-texlive/texlive-latexextra
	)"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-docutils-0.6.patch"
	epatch "${FILESDIR}/${PN}-python-2.6.patch"
}

src_install() {
	distutils_src_install

	doman man/*
	use doc && dohtml -r doc/*
	use X || rm -f "${ED}usr/bin/epydocgui"
}
