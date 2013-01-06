# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/flint/flint-2.3.ebuild,v 1.1 2012/11/26 08:06:33 patrick Exp $

EAPI="5"

inherit eutils

DESCRIPTION="Fast Library for Number Theory"
HOMEPAGE="http://www.flintlib.org/"
SRC_URI="http://www.flintlib.org/${P}.tar.gz"

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/mpfr
	dev-libs/ntl
	sci-libs/mpir
	"
RDEPEND="${DEPEND}"

src_configure() {
	# handwritten script, needs extra stabbing
	./configure --with-mpir=/usr --with-mpfr=/usr --with-ntl=/usr --prefix="${D}/usr" || die
}
