# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/recordmydesktop/recordmydesktop-0.3.8.1-r1.ebuild,v 1.1 2010/01/04 14:29:40 ssuominen Exp $

EAPI=2

DESCRIPTION="A desktop session recorder producing Ogg video/audio files"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/recordmydesktop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa jack"

RDEPEND="sys-libs/zlib
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXdamage
	media-libs/libvorbis
	media-libs/libogg
	media-libs/libtheora[encode]
	x11-libs/libICE
	x11-libs/libSM
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_prepare() {
	if has_version ">=x11-proto/xextproto-7.1.1"; then
		sed -i \
			-e 's:shmstr.h:shmproto.h:g' \
			src/{rmd_getzpixmap.c,rmd_update_image.c} || die
	fi
}

src_configure() {
	econf \
		--enable-dependency-tracking \
		$(use_enable !alsa oss) \
		$(use_enable jack)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
