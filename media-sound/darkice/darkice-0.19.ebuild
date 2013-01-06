# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-0.19.ebuild,v 1.9 2009/08/03 13:13:55 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="IceCast live streamer, delivering ogg and mp3 streams simultaneously to multiple hosts."
HOMEPAGE="http://darkice.sourceforge.net"
SRC_URI="http://${PN}.tyrell.hu/dist/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="aac alsa jack mp3 twolame vorbis"

RDEPEND="mp3? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	aac? ( media-libs/faac )
	twolame? ( media-sound/twolame )
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	!mp3? ( !vorbis? ( !aac? ( !twolame? ( media-sound/lame ) ) ) )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.18.1-gcc43.patch \
		"${FILESDIR}"/${P}-gcc44.patch
}

src_configure() {
	local myconf

	if ! use mp3 && ! use vorbis && ! use aac && ! use twolame; then
		ewarn "One of USE flags mp3, vorbis, aac, or twolame is required."
		ewarn "Selecting mp3 for you."
		myconf="--with-lame"
	fi

	econf $(use_with aac faac) \
		$(use_with alsa) \
		$(use_with mp3 lame) \
		$(use_with jack) \
		$(use_with twolame) \
		$(use_with vorbis) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
