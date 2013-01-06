# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/skype4py/skype4py-1.0.32.1.ebuild,v 1.1 2012/11/25 07:08:29 radhermit Exp $

EAPI="5"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
# ctypes module required.
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils eutils

MY_PN="Skype4Py"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python wrapper for the Skype API"
HOMEPAGE="https://github.com/awahlig/skype4py http://pypi.python.org/pypi/Skype4Py/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="net-im/skype"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${P}-python.patch
}
