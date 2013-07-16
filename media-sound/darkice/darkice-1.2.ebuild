# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-1.2.ebuild,v 1.2 2013/07/16 14:08:20 polynomial-c Exp $

EAPI=5
inherit eutils

DESCRIPTION="A live audio streamer"
HOMEPAGE="http://code.google.com/p/darkice/"
SRC_URI="http://darkice.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="aac alsa jack libsamplerate mp3 opus pulseaudio twolame vorbis"

RDEPEND="aac? ( media-libs/faac )
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	mp3? ( media-sound/lame )
	opus? ( media-libs/opus )
	pulseaudio? ( media-sound/pulseaudio )
	twolame? ( media-sound/twolame )
	vorbis? ( media-libs/libvorbis )
	libsamplerate? ( media-libs/libsamplerate )"
DEPEND="${RDEPEND}"

REQUIRED_USE="|| ( aac mp3 opus twolame vorbis )
		|| ( alsa jack pulseaudio )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc47.patch
}

src_configure() {
	econf \
		$(use_with mp3 lame) \
		$(use_with vorbis) \
		$(use_with aac faac) \
		--without-aacplus \
		$(use_with twolame) \
		$(use_with opus) \
		$(use_with alsa) \
		$(use_with jack) \
		$(use_with pulseaudio) \
		$(use_with libsamplerate samplerate)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
