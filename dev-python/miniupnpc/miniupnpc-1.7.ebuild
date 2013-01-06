# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/miniupnpc/miniupnpc-1.7.ebuild,v 1.1 2012/07/11 08:11:08 mgorny Exp $

EAPI=4

PYTHON_COMPAT="python2_6 python2_7"

inherit eutils python-distutils-ng

DESCRIPTION="Python bindings for UPnP client library"
HOMEPAGE="http://miniupnp.free.fr/"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=net-libs/miniupnpc-${PV}"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch_user
	epatch "${FILESDIR}"/0001-Link-Python-module-against-the-shared-library.patch

	python-distutils-ng_src_prepare
}
