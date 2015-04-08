# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pmw/pmw-1.3.2-r2.ebuild,v 1.10 2013/01/29 12:35:56 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils eutils

MY_P="Pmw.${PV}"

DESCRIPTION="Toolkit for building high-level compound widgets in Python using the Tkinter module"
HOMEPAGE="http://pmw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc examples"

DEPEND="
	!dev-python/pmw:py2
	!dev-python/pmw:py3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/src"

DOCS="Pmw/README"
PYTHON_MODNAME="Pmw"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-install-no-docs.patch"
	epatch "${FILESDIR}/${PV}-python2.5.patch"
}

src_install() {
	distutils_src_install

	local DIR="${PYTHON_MODNAME}/Pmw_1_3"

	if use doc; then
		dohtml -a html,gif,py "${DIR}"/doc/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins "${DIR}"/demos/* || die "Installation of demos failed"
	fi
}
