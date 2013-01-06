# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/miniupnpc/miniupnpc-1.6.20120509.ebuild,v 1.1 2012/05/24 01:11:52 ssuominen Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"

inherit distutils eutils

DESCRIPTION="UPnP client library and a simple UPnP client"
HOMEPAGE="http://miniupnp.free.fr/"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=net-libs/miniupnpc-${PV}"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/0001-Link-Python-module-against-the-shared-library.patch
	rm -f Changelog.txt README # Installed by net-libs/miniupnpc

	distutils_src_prepare
}
