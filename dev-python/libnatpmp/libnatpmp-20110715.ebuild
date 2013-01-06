# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libnatpmp/libnatpmp-20110715.ebuild,v 1.1 2011/08/07 02:51:55 blueness Exp $

EAPI=3
PYTHON_DEPEND=2
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

DESCRIPTION="Python module for libnatpmp, an alternative protocol to UPnP IGD."
HOMEPAGE="http://miniupnp.free.fr/libnatpmp.html"
SRC_URI="http://miniupnp.free.fr/files/download.php?file=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libnatpmp"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/link-against-system-lib.patch
	distutils_src_prepare

	#These are installed by net-libs/libnatpmp
	rm -f Changelog.txt README || die
}
