# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/bcm2835/bcm2835-1.11.ebuild,v 1.1 2012/10/31 23:45:06 chithanh Exp $

EAPI=4

DESCRIPTION="Provides access to GPIO and other IO functions on the Broadcom BCM2835"
HOMEPAGE="http://www.open.com.au/mikem/bcm2835/"
SRC_URI="http://www.open.com.au/mikem/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"
IUSE="doc examples"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_install() {
	default
	if use examples; then
		dodoc -r examples
	fi
	if use doc; then
		dohtml -r doc/html/.
	fi
}
