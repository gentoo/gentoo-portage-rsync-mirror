# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/librharris/librharris-0.1.14.ebuild,v 1.2 2010/11/08 17:59:48 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="lib_rharris"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python Internet Programming Library"
HOMEPAGE="http://pypi.python.org/pypi/lib_rharris"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="changelog"
PYTHON_MODNAME="${MY_PN}"
