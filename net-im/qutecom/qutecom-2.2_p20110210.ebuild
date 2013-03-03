# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qutecom/qutecom-2.2_p20110210.ebuild,v 1.13 2013/03/02 22:53:48 hwoarang Exp $

EAPI="3"

inherit cmake-utils eutils flag-o-matic versionator

DESCRIPTION="Multi-protocol instant messenger and VoIP client"
HOMEPAGE="http://www.qutecom.org/"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug oss portaudio xv"

RDEPEND="dev-libs/boost
	dev-libs/glib
	dev-libs/openssl
	alsa? ( media-libs/alsa-lib )
	media-libs/libsamplerate
	media-libs/libsndfile
	portaudio? ( media-libs/portaudio )
	media-libs/speex
	net-im/pidgin[gnutls]
	net-libs/gnutls
	>=net-libs/libosip-3
	>=net-libs/libeXosip-3
	net-misc/curl
	virtual/ffmpeg
	x11-libs/libX11
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	xv? ( x11-libs/libXv )"
DEPEND="${RDEPEND}
	media-libs/libv4l"

pkg_setup() {
	# fails to find its libraries with --as-needed, bug #315045
	append-ldflags $(no-as-needed)
}

src_prepare() {
	# find correct version of boost, bug #425440
	local boost_PF="$(best_version dev-libs/boost)"
	local boost_PV="$(get_version_component_range 5-7 ${boost_PF})"
	local boost_PV1="$(get_version_component_range 5-6 ${boost_PF})"
	sed -i "s:usr/include:usr/include/boost-$(replace_all_version_separators _ ${boost_PV}):" owbuild/FindBoost.cmake || die
	sed -i "s:usr/local/include:usr/include/boost-$(replace_all_version_separators _ ${boost_PV1}):" owbuild/FindBoost.cmake || die
	sed -i "s:usr/lib:usr/lib/boost-$(replace_all_version_separators _ ${boost_PV}):" owbuild/FindBoost.cmake || die
	sed -i "s:usr/local/lib:usr/lib/boost-$(replace_all_version_separators _ ${boost_PV1}):" owbuild/FindBoost.cmake || die

	# fix building against gcc-4.7, bug #425440
	epatch "${FILESDIR}"/${PN}-2.2-boost-1.50.patch

	# build against >=linux-headers-2.6.38, bug 361181
	sed -i -e "s|linux/videodev.h|libv4l1-videodev.h|" \
		-e "s|__u16|uint16_t|" \
		libs/pixertool/src/v4l/v4l-pixertool.c \
		libs/webcam/include/webcam/V4LWebcamDriver.h \
		libs/webcam/src/v4l/V4LWebcamDriver.cpp || die
	epatch "${FILESDIR}"/${PN}-2.2-no-deprecated-avcodec-decode-video.patch \
		"${FILESDIR}"/${PN}-2.2-ffmpeg-1.patch
	# do not include gtypes.h, bug #421415
	sed -i '/gtypes.h/d' libs/imwrapper/src/purple/PurpleIMFactory.h || die
}

src_configure() {
	local mycmakeargs="$(cmake-utils_use_enable portaudio PORTAUDIO_SUPPORT)
		$(cmake-utils_use_enable alsa PHAPI_AUDIO_ALSA_SUPPORT)
		$(cmake-utils_use_enable oss PHAPI_AUDIO_OSS_SUPPORT)
		$(cmake-utils_use_enable xv WENGOPHONE_XV_SUPPORT)
		-DLIBPURPLE_INTERNAL=OFF
		-DPORTAUDIO_INTERNAL=OFF
		-DCMAKE_VERBOSE_MAKEFILE=ON "

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	domenu ${PN}/res/${PN}.desktop || die "domenu failed"
	doicon ${PN}/res/${PN}_64x64.png || die "doicon failed"

}
