# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-graphtft/vdr-graphtft-0.3.4.ebuild,v 1.2 2012/04/07 01:36:55 hd_brummy Exp $

EAPI="4"

RESTRICT="test"

inherit eutils vdr-plugin flag-o-matic

S="${WORKDIR}/graphtft-30"

DESCRIPTION="VDR plugin: GraphTFT"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Graphtft-plugin"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

IUSE_THEMES="+theme_deepblue theme_avp theme_deeppurple theme_poetter"
IUSE="${IUSE_THEMES} directfb graphtft-fe imagemagick touchscreen"

DEPEND=">=media-video/vdr-1.6.0_p2-r1[graphtft]
		media-libs/imlib2[png,jpeg]
		gnome-base/libgtop
		>=virtual/ffmpeg-0.4.8_p20090201
		imagemagick? ( media-gfx/imagemagick[png,jpeg,cxx] )
		directfb? ( dev-libs/DirectFB )
		graphtft-fe? ( media-libs/imlib2[png,jpeg,X] )"

RDEPEND="${DEPEND}"

PDEPEND="theme_deepblue? ( =x11-themes/vdrgraphtft-deepblue-0.3.1 )
		theme_avp? ( =x11-themes/vdrgraphtft-avp-0.3.1 )
		theme_deeppurple? ( =x11-themes/vdrgraphtft-deeppurple-0.3.2 )
		theme_poetter? ( =x11-themes/vdrgraphtft-poetter-0.3.2 )"

PATCHES=("${FILESDIR}/${P}_gentoo.diff"
		"${FILESDIR}/${PN}-0.3.2.24_makefile.diff"
		"${FILESDIR}/${P}_gcc-4.4.x.diff"
		"${FILESDIR}/${P}_vdr-1.7.26_ChannelSwitch.patch")

src_prepare() {

	sed -i Makefile -e "s:  WITH_X_COMM = 1:#WITH_X_COMM = 1:"

	! use touchscreen && sed -i Makefile -e "s:WITH_TOUCH = 1:#WITH_TOUCH = 1:"

	use graphtft-fe && sed -i Makefile \
		-e "s:#WITH_X_COMM:WITH_X_COMM:"

	vdr-plugin_src_prepare

	sed -i "${S}"/imlibrenderer/fbrenderer/fbrenderer.c \
		-i "${S}"/imlibrenderer/dvbrenderer/mpeg2encoder.c \
		-e "s:libavutil/avcodec.h:libavcodec/avcodec.h:"

	# UINT64_C is needed by ffmpeg headers
	append-flags -D__STDC_CONSTANT_MACROS

	if has_version ">=media-video/vdr-1.7.27"; then
		epatch "${FILESDIR}/vdr-1.7.27.diff"
	fi
}

src_compile() {
	vdr-plugin_src_compile

	if use graphtft-fe; then
		cd "${S}"/graphtft-fe
		emake
	fi
}

src_install() {
	vdr-plugin_src_install

	dodoc "${S}"/documents/{README,HISTORY,HOWTO.Themes,INSTALL}

	if use graphtft-fe; then
		cd "${S}"/graphtft-fe && dobin graphtft-fe
		doinit graphtft-fe
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	if use graphtft-fe; then
		echo
		elog "Graphtft-fe user:"
		elog "Edit /etc/conf.d/vdr.graphtft"
		elog "/etc/init.d/graphtft-fe start"
		echo
	fi
}
