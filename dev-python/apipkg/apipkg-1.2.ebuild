# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apipkg/apipkg-1.2.ebuild,v 1.2 2012/06/19 17:44:19 xarthisius Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST=py.test

inherit distutils

DESCRIPTION="namespace control and lazy-import mechanism"
HOMEPAGE="http://pypi.python.org/pypi/apipkg"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND=""

DOCS="CHANGELOG README.txt"
PYTHON_MODNAME=${PN}.py
