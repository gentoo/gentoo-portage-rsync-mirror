# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/genetic/genetic-0.1.1.ebuild,v 1.3 2010/07/23 20:10:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

MY_PN="${PN/#g/G}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A package for genetic algorithms in Python"
HOMEPAGE="http://home.gna.org/oomadness/en/genetic/"
SRC_URI="http://download.gna.org/oomadness/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PV}-import-future-at-beginning.patch"
}
