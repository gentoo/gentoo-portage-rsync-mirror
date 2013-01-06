# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmirage/libmirage-1.4.0.ebuild,v 1.3 2012/05/04 18:35:43 jdhore Exp $

EAPI="4"

DESCRIPTION="CD and DVD image access library"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/glib-2.6:2
	>=media-libs/libsndfile-1.0
	sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || find "${D}" -name '*.la' -exec rm -f {} +
}
