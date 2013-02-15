# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.10.13_p201211.ebuild,v 1.2 2013/02/15 18:25:45 aballier Exp $

EAPI=5

inherit base eutils flag-o-matic

MY_PN="gst-ffmpeg"
MY_P=${MY_PN}-${PV}

# Create a major/minor combo for SLOT
PVP=(${PV//[-\._]/ })
SLOT=${PVP[0]}.${PVP[1]}

DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-ffmpeg.html"
#SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"
SRC_URI="http://dev.gentoo.org/~tetromino/distfiles/${PN}/${MY_P}.tar.xz
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${MY_P}-libav-9-patches.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="+orc"

S=${WORKDIR}/${MY_P}

RDEPEND=">=media-libs/gstreamer-0.10.31:0.10
	>=media-libs/gst-plugins-base-0.10.31:0.10
	>=virtual/ffmpeg-0.10
	|| ( media-video/ffmpeg media-libs/libpostproc )
	orc? ( >=dev-lang/orc-0.4.6 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -e 's/sleep 15//' -i configure.ac configure || die

	# libav-9 support backported from gst-plugins-libav-1.1.0
	epatch ../${MY_P}-libav-9-patches/*.patch

	# monkey's audio requires planar audio support to be backported
	sed -e 's#[ \t]elements/ffdemux_ape[^ ]*##' -i tests/check/Makefile.{am,in} || die

	# compat bits for older ffmpeg/libav releases
	epatch "${FILESDIR}/${PV}-channel_layout.patch" \
		"${FILESDIR}/${PV}-iscodec.patch" \
		"${FILESDIR}/${PV}-coma.patch"
}

src_configure() {
	# always use system ffmpeg if possible
	econf \
		--with-system-ffmpeg \
		$(use_enable orc)
}

src_install() {
	default
	prune_libtool_files --modules
}

pkg_postinst() {
	if has_version "media-video/ffmpeg"; then
		elog "Please note that upstream uses media-video/libav"
		elog "rather than media-video/ffmpeg. If you encoutner any"
		elog "issues try to move from ffmpeg to libav."
	fi
}
