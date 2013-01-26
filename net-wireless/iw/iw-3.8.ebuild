# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iw/iw-3.8.ebuild,v 1.2 2013/01/26 05:23:30 zerochaos Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="nl80211-based configuration utility for wireless devices using the mac80211 kernel stack"
HOMEPAGE="http://wireless.kernel.org/en/users/Documentation/iw"
SRC_URI="http://linuxwireless.org/download/${PN}/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/libnl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	tc-export CC LD
}

src_compile() {
	emake V=1
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EROOT}/usr" install
}
