# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.64.0.ebuild,v 1.8 2012/05/05 08:53:55 mgorny Exp $

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="vorbis"

RDEPEND="media-libs/libmad
	media-libs/faad2
	>=dev-libs/glib-2.16
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	econf --disable-dependency-tracking $(use_with vorbis ogg) \
		--without-included-libmad --without-included-glib \
		--without-included-argv --without-included-cdk
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc CHANGES README THANKS
}
