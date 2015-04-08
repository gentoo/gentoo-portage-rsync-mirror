# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.3.ebuild,v 1.8 2014/01/18 12:16:08 vapier Exp $

EAPI="4"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml(+)"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Library for manipulating TrueType, OpenType, AFM and Type1 fonts"
HOMEPAGE="http://fonttools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 ia64 ppc x86"
IUSE=""

DEPEND=">=dev-python/numpy-1.0.2"
RDEPEND="${DEPEND}"

DOCS="README.txt Doc/*.txt"
PYTHON_MODNAME="FontTools"

src_install() {
	distutils_src_install
	dohtml Doc/*.html || die "dohtml failed"
}
