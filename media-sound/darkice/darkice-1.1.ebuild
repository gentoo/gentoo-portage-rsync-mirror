# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-1.1.ebuild,v 1.1 2011/12/13 16:28:27 beandog Exp $

EAPI=2
inherit eutils

DESCRIPTION="A live audio streamer"
HOMEPAGE="http://code.google.com/p/darkice/"
SRC_URI="http://darkice.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="aac alsa jack libsamplerate mp3 twolame vorbis"

RDEPEND="aac? ( media-libs/faac )
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	mp3? ( media-sound/lame )
	twolame? ( media-sound/twolame )
	vorbis? ( media-libs/libvorbis )
	libsamplerate? ( media-libs/libsamplerate )
	!mp3? ( !vorbis? ( !aac? ( !twolame? ( media-sound/lame ) ) ) )"
DEPEND="${RDEPEND}"

#src_prepare() {
#	epatch "${FILESDIR}"/${P}-gcc44.patch
#}

src_configure() {
	local myconf

	if ! use mp3 && ! use vorbis && ! use aac && ! use twolame; then
		myconf="--with-lame"
	fi

	econf \
		--disable-dependency-tracking \
		$(use_with mp3 lame) \
		$(use_with vorbis) \
		$(use_with aac faac) \
		--without-aacplus \
		$(use_with twolame) \
		$(use_with alsa) \
		$(use_with jack) \
		$(use_with libsamplerate samplerate) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
