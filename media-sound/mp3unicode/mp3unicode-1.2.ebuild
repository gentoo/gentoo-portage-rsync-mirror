# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3unicode/mp3unicode-1.2.ebuild,v 1.3 2012/05/05 08:39:19 mgorny Exp $

DESCRIPTION="MP3Unicode is a command line utility to convert ID3 tags in mp3 files between different encodings"
HOMEPAGE="http://mp3unicode.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/taglib-1.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	rm -rf "${D}"/usr/share/doc/${PN}
	dodoc AUTHORS ChangeLog README
}
