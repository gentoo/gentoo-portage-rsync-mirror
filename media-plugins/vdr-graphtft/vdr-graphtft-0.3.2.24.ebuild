# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-graphtft/vdr-graphtft-0.3.2.24.ebuild,v 1.8 2011/04/06 17:08:37 idl0r Exp $

EAPI="3"

RESTRICT="test"

inherit eutils vdr-plugin flag-o-matic

S="${WORKDIR}/graphtft-24"

DESCRIPTION="VDR plugin: GraphTFT"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Graphtft-plugin"
SRC_URI="http://vdr.websitec.de/download/${PN}/${P}.tar.bz2"

KEYWORDS="~x86 ~amd64"
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
		"${FILESDIR}/${P}_makefile.diff"
		"${FILESDIR}/${P}_gcc-4.4.x.diff"
		"${FILESDIR}/${P}_ffmpeg-0.5.diff")

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
