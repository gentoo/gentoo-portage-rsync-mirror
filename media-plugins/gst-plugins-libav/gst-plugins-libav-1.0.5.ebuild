# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libav/gst-plugins-libav-1.0.5.ebuild,v 1.1 2013/01/21 23:10:50 eva Exp $

EAPI="5"

inherit eutils flag-o-matic

MY_PN="gst-libav"
DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-libav.html"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_PN}-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="1.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="+orc"

RDEPEND="
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	>=virtual/ffmpeg-0.10.3
	orc? ( >=dev-lang/orc-0.4.16 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
	virtual/pkgconfig
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	sed -e 's/sleep 15//' -i configure.ac configure || die
}

src_configure() {
	GST_PLUGINS_BUILD=""
	# always use system ffmpeg/libav if possible
	econf \
		--disable-maintainer-mode \
		--with-package-name="Gentoo GStreamer ebuild" \
		--with-package-origin="http://www.gentoo.org" \
		--with-system-libav \
		$(use_enable orc)
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	default
	prune_libtool_files --modules
}

pkg_postinst() {
	if has_version "media-video/ffmpeg"; then
		elog "Please note that upstream uses media-video/libav"
		elog "rather than media-video/ffmpeg. If you encounter any"
		elog "issues try to move from ffmpeg to libav."
	fi
}
