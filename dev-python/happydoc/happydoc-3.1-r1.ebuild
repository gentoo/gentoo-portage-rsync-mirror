# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/happydoc/happydoc-3.1-r1.ebuild,v 1.2 2012/12/01 02:00:42 radhermit Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils versionator

MY_PN="HappyDoc"
MY_PV=$(replace_all_version_separators "_" ${PV})
MY_V=$(get_major_version ${PV})

DESCRIPTION="Tool for extracting documentation from Python source code"
HOMEPAGE="http://happydoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}_r${MY_PV}.tar.gz"

LICENSE="HPND ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

# Tests need extra data not present in the release tarball.
RESTRICT="test"

S="${WORKDIR}/${MY_PN}${MY_V}-r${MY_PV}"

PYTHON_MODNAME="happydoclib"

src_prepare() {
	distutils_src_prepare
	cp "${FILESDIR}/${P}-setup.py" setup.py || die "Copying of setup.py failed"
	epatch "${FILESDIR}/${P}-python-2.6.patch"
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r "srcdocs/${MY_PN}${MY_V}-r${MY_PV}"/* || die "Installation of documentation failed"
	fi
}
