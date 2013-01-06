# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simples3/simples3-1.0.ebuild,v 1.1 2011/12/01 14:36:19 djc Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils versionator

DESCRIPTION="A fairly simple, decently quick python interface to Amazon's S3 storage service"
HOMEPAGE="http://lericson.se/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT_PYTHON_ABIS="2.4 3.*"

DOCS="changes.rst"

src_prepare() {
	sed -i -e "s/setuptools/distutils.core/" setup.py || die
}
