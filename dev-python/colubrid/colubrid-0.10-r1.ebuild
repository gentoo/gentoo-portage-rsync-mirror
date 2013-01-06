# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/colubrid/colubrid-0.10-r1.ebuild,v 1.4 2010/11/08 19:09:50 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

MY_P="Colubrid-${PV}"

DESCRIPTION="Colubrid is a set of tools around the WSGI standard"
HOMEPAGE="http://wsgiarea.pocoo.org/colubrid/ http://pypi.python.org/pypi/Colubrid"
SRC_URI="http://wsgiarea.pocoo.org/colubrid/dist/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}.patch"
}
