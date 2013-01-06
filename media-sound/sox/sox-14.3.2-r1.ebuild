# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-14.3.2-r1.ebuild,v 1.12 2012/05/05 08:54:02 mgorny Exp $

EAPI=4
inherit eutils flag-o-matic

DESCRIPTION="The swiss army knife of sound processing programs"
HOMEPAGE="http://sox.sourceforge.net"
SRC_URI="mirror://sourceforge/sox/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="alsa amr ao debug encode ffmpeg flac id3tag ladspa mad ogg openmp oss png pulseaudio sndfile static-libs wavpack"

# libtool required for libltdl
RDEPEND=">=sys-devel/libtool-2.2.6b
	alsa? ( media-libs/alsa-lib )
	amr? ( media-libs/opencore-amr )
	encode? ( >=media-sound/lame-3.98.4 )
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad )
	sndfile? ( media-libs/libsndfile )
	ogg? ( media-libs/libvorbis	media-libs/libogg )
	ao? ( media-libs/libao )
	ffmpeg? ( virtual/ffmpeg )
	ladspa? ( media-libs/ladspa-sdk )
	>=media-sound/gsm-1.0.12-r1
	id3tag? ( media-libs/libid3tag )
	png? ( media-libs/libpng sys-libs/zlib )
	pulseaudio? ( media-sound/pulseaudio )
	wavpack? ( media-sound/wavpack )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	sed -i -e 's:CFLAGS="-g":CFLAGS="$CFLAGS -g":' configure || die #386027

	epatch \
		"${FILESDIR}"/${P}-uclibc.patch \
		"${FILESDIR}"/${P}-ffmpeg.patch
}

src_configure() {
	# Fixes wav segfaults. See Bug #35745.
	append-flags -fsigned-char

	econf \
		$(use_enable static-libs static) \
		$(use_with alsa) \
		$(use_enable debug) \
		$(use_enable openmp gomp) \
		$(use_with ao) \
		$(use_with oss) \
		$(use_with encode lame) \
		$(use_with mad) \
		$(use_with sndfile) \
		$(use_with flac) \
		$(use_with ogg oggvorbis) \
		$(use_with ffmpeg) \
		$(use_with ladspa) \
		$(use_with id3tag) \
		$(use_with amr amrwb) \
		$(use_with amr amrnb) \
		$(use_with png) \
		$(use_with pulseaudio) \
		$(use_with wavpack) \
		--with-distro="Gentoo"
}

src_install() {
	default
	# libltdl is used for loading plugins, keeping libtool files with empty
	# dependency_libs what otherwise would be -exec rm -f {} +
	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
