# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libe/libe-0.4.1.ebuild,v 1.1 2013/12/17 05:39:27 patrick Exp $
EAPI=4

inherit eutils

# bit messy at the moment, next release should fix it I hope
RESTRICT="test"

DESCRIPTION="Hyperdex libe support library"

HOMEPAGE="http://hyperdex.org"
SRC_URI="http://hyperdex.org/src/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND=">=dev-libs/libpo6-${PV}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i -e 's/_strtoui64/strtoul/' e/convert.h || die
}
