# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygui/pygui-2.2-r1.ebuild,v 1.3 2010/07/23 21:29:41 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

MY_P="PyGUI-${PV}"

DESCRIPTION="A cross-platform pythonic GUI API"
HOMEPAGE="http://www.cosc.canterbury.ac.nz/greg.ewing/python_gui/"
SRC_URI="http://www.cosc.canterbury.ac.nz/greg.ewing/python_gui/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

PYTHON_MODNAME="GUI"

src_prepare() {
	distutils_src_prepare

	# "as" is a keyword
	epatch "${FILESDIR}"/${P}-python-2.6.patch

	# Fixing a typo in setup.py
	epatch "${FILESDIR}"/${P}-resources.patch
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml Doc/* || die "Installing html documentation failed"
	fi

	if use examples; then
		pushd Tests
		insinto /usr/share/doc/${PF}/examples
		doins *.py *.tiff *.jpg || die "Installing examples failed"
		doins -r ../Demos/* || die "Installing demos failed"
		popd
	fi
}
