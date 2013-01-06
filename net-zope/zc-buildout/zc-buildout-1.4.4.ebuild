# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zc-buildout/zc-buildout-1.4.4.ebuild,v 1.1 2010/09/12 20:13:21 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P=${MY_PN}-${PV}

DESCRIPTION="System for managing development buildouts"
HOMEPAGE="http://pypi.python.org/pypi/zc.buildout"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

DOCS="CHANGES.txt todo.txt"
PYTHON_MODNAME="${PN/-//}"

src_install() {
	distutils_src_install

	# Remove README.txt installed in incorrect location.
	rm -f "${D}usr/README.txt"
}
