# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-music/vdr-music-0.2.0.ebuild,v 1.8 2010/12/30 00:02:54 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: music"
HOMEPAGE="http://www.vdr.glaserei-franz.de/"
SRC_URI="http://www.kost.sh/vdr/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="imagemagick debug vorbis oss ff-card graphtft 4mb-mod sndfile"

PATCHES=( "${FILESDIR}/${P}-gentoo.diff"
	"${FILESDIR}/${P}-vdr-1.5.x.diff"
	"${FILESDIR}/${P}-lyrics.diff"
	"${FILESDIR}/${P}-gcc4.3.diff"
	"${FILESDIR}/${P}-glibc-2.10.patch"
	"${FILESDIR}/${P}-ImageMagick-header.diff" )

DEPEND=">=media-video/vdr-1.3.30
	media-libs/libmad
	media-libs/libid3tag
	imagemagick? ( media-gfx/imagemagick[png] )
	vorbis? ( media-libs/libvorbis )
	sndfile? ( media-libs/libsndfile )
	oss? ( media-libs/alsa-oss )
	!imagemagick? ( media-libs/imlib2[png] )"

RDEPEND="${DEPEND}
	virtual/jre
	media-tv/shoutcast2vdr
	sys-process/at
	graphtft? ( >=media-plugins/vdr-graphtft-0.1.5 )"

src_prepare() {
	use graphtft && epatch "${FILESDIR}/${P}-graphtftcoverfix.diff"

	use !ff-card && sed -i Makefile -e "s:HAVE_FFCARD=1:#HAVE_FFCARD=1:"
	use !vorbis && sed -i Makefile -e "s:#WITHOUT_LIBVORBISFILE=1:WITHOUT_LIBVORBISFILE=1:"
	use !sndfile && sed -i Makefile -e "s:#WITHOUT_LIBSNDFILE=1:WITHOUT_LIBSNDFILE=1:"
	use imagemagick && sed -i Makefile -e "s:#HAVE_MAGICK=1:HAVE_MAGICK=1:"
	use oss && sed -i Makefile -e "s:#WITH_OSS_OUTPUT=1:WITH_OSS_OUTPUT=1:"
	use 4mb-mod && sed -i Makefile -e "s:#HAVE_OSDMOD=1:HAVE_OSDMOD=1:"
	use debug && sed -i Makefile -e "s:#DBG=1:DBG=1:"

	vdr-plugin_src_prepare
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/music
	doins music/musicsources.conf

	insinto /etc/vdr/plugins/music/coverviewer
	doins -r music/coverviewer/*

	insinto /etc/vdr/plugins/music/data
	doins -r music/data/*

	exeinto /etc/vdr/plugins/music/downloads/music_cover
	doexe music/downloads/music_cover/*

	insinto /etc/vdr/plugins/music/playlists
	doins music/playlists/*

	insinto /etc/vdr/plugins/music/themes
	doins -r music/themes/*

	insinto /etc/vdr/plugins/music/visual
	doins -r music/visual/*

	exeinto /usr/share/vdr/music/scripts
	doexe music/scripts/*

	keepdir /etc/vdr/plugins/music/lyrics
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "To complete your media-plugins/vdr-music install"
	elog "take a look on:"
	echo
	elog "media-plugins/vdr-coverviewer"
	elog "media-plugins/vdr-picselshow"
	echo
	elog " Please change your /etc/vdr/plugins/music/musicsources.conf "
	echo
}
