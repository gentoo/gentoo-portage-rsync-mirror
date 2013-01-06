# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/piedock/piedock-1.6.0.ebuild,v 1.1 2012/04/10 07:49:46 hwoarang Exp $

EAPI=4

DESCRIPTION="A little bit like the famous OS X dock but in shape of a pie menu"
HOMEPAGE="http://markusfisch.de/PieDock"
SRC_URI="http://markusfisch.de/downloads/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-libs/freetype:2
	media-libs/libpng
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXmu
	x11-libs/libXrender
"
RDEPEND="${DEPEND}"

DOCS=(
	res/${PN}rc.sample
)

src_configure() {
	econf --bindir="${EPREFIX}"/usr/bin
}
