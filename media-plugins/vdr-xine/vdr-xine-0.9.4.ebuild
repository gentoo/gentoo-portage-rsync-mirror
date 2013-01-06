# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xine/vdr-xine-0.9.4.ebuild,v 1.2 2012/01/10 21:50:41 idl0r Exp $

EAPI=3

inherit vdr-plugin

DESCRIPTION="VDR plugin: for 'software only' playback using xine"
HOMEPAGE="http://home.vr-web.de/~rnissl/"
SRC_URI="http://home.vr-web.de/~rnissl/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="nls yaepg"

COMMON_DEP=">=media-video/vdr-1.3.9
	>=media-libs/xine-lib-1.1.8[vdr]"
DEPEND="${COMMON_DEP}
	nls? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEP}
	media-video/mjpegtools
	media-libs/netpbm
	media-video/y4mscaler"

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-build-system.patch"

	use yaepg && sed -i Makefile -e "s:#VDR_XINE_SET_VIDEO_WINDOW:VDR_XINE_SET_VIDEO_WINDOW:"

	vdr-plugin_src_prepare
}

src_compile() {
	BUILD_PARAMS="VDR_XINE_FIFO_DIR=/var/vdr/xine"

	if use nls; then
		BUILD_PARAMS+=" ENABLE_I18N=yes"
	fi

	vdr-plugin_src_compile
}

src_install() {
	vdr-plugin_src_install

	dobin xineplayer || die

	insinto /usr/share/vdr/xine
	doins data/* || die

	dodoc MANUAL
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	if [[ -d ${ROOT}/etc/vdr/plugins/xine ]]; then
		ewarn "You have a leftover directory of vdr-xine."
		ewarn "You can safely remove it with:"
		ewarn "# rm -rf /etc/vdr/plugins/xine"
	fi
}
