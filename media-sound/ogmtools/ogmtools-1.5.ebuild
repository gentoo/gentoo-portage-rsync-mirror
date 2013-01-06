# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ogmtools/ogmtools-1.5.ebuild,v 1.8 2009/06/01 16:19:39 ssuominen Exp $

inherit eutils

DESCRIPTION="Information, extraction or creation for OGG media streams"
HOMEPAGE="http://www.bunkus.org/videotools/ogmtools/"
SRC_URI="http://www.bunkus.org/videotools/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="dvd"

RDEPEND="dvd? ( media-libs/libdvdread )
	media-sound/vorbis-tools"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-endian-fix.patch
}

src_compile() {
	econf $(use_with dvd dvdread)
	emake || die "emake failed"
}

src_install() {
	dobin ogmmerge ogmdemux ogminfo ogmsplit ogmcat || die
	use dvd && dobin dvdxchap
	dodoc TODO README ChangeLog
	doman dvdxchap.1 ogmcat.1 ogmdemux.1 ogminfo.1 ogmmerge.1 ogmsplit.1
}
