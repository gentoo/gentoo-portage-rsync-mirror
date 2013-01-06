# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra/cinelerra-20120707.ebuild,v 1.3 2012/10/17 03:25:31 phajdan.jr Exp $

EAPI=4
inherit autotools eutils multilib flag-o-matic

DESCRIPTION="The most advanced non-linear video editor and compositor"
HOMEPAGE="http://www.cinelerra.org/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="3dnow alsa altivec css ieee1394 mmx opengl oss"

RDEPEND="media-libs/a52dec
	media-libs/faac
	media-libs/faad2
	>=media-libs/freetype-2
	media-libs/libdv
	>=media-libs/libogg-1.2
	media-libs/libpng:0
	media-libs/libsndfile
	>=media-libs/libtheora-1.1
	>=media-libs/libvorbis-1.3
	>=media-libs/openexr-1.5
	media-libs/tiff:0
	media-libs/x264
	media-sound/lame
	>=media-video/mjpegtools-2
	>=sci-libs/fftw-3
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXv
	x11-libs/libXvMC
	x11-libs/libXxf86vm
	virtual/ffmpeg
	virtual/jpeg
	alsa? ( media-libs/alsa-lib )
	ieee1394? (
		media-libs/libiec61883
		>=sys-libs/libraw1394-1.2.0
		>=sys-libs/libavc1394-0.5.0
		)
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	mmx? ( dev-lang/nasm )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-entry.patch \
		"${FILESDIR}"/${PN}-ffmpeg.patch \
		"${FILESDIR}"/${PN}-underlinking.patch \
		"${FILESDIR}"/${PN}-ffmpeg-0.11.patch

	eautoreconf
}

src_configure() {
	append-flags -D__STDC_CONSTANT_MACROS #321945
	append-ldflags -Wl,-z,noexecstack #212959

	econf \
		$(use_enable oss) \
		$(use_enable alsa) \
		--disable-esd \
		$(use_enable ieee1394 firewire) \
		$(use_enable css) \
		$(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable altivec) \
		$(use_enable opengl) \
		--with-plugindir=/usr/$(get_libdir)/${PN} \
		--with-buildinfo=cust/"Gentoo - ${PV}" \
		--with-external-ffmpeg
}

src_install() {
	emake DESTDIR="${D}" install
	dohtml -a png,html,texi,sdw -r doc/*

	rm -rf "${D}"/usr/include
	mv -vf "${D}"/usr/bin/mpeg3cat{,.hv} || die
	mv -vf "${D}"/usr/bin/mpeg3dump{,.hv} || die
	mv -vf "${D}"/usr/bin/mpeg3toc{,.hv} || die
	dosym /usr/bin/mpeg2enc /usr/$(get_libdir)/${PN}/mpeg2enc.plugin

	prune_libtool_files --all
}
