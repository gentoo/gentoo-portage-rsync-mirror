# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvideo/gst-plugins-xvideo-0.10.35.ebuild,v 1.11 2012/12/02 18:31:39 eva Exp $

EAPI="3"

inherit gst-plugins-base gst-plugins10

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libXv
	x11-libs/libXext

	x11-libs/libSM
	x11-libs/libICE"
# libSM and libICE are not used, but the build system links to them anyway
# Fixed in >=0.10.35-r1
DEPEND="${RDEPEND}
	x11-proto/videoproto
	x11-proto/xproto
	x11-proto/xextproto"

# xshm is a compile time option of xvideo
# x is needed to build any X plugins, but we build/install only xv anyway
GST_PLUGINS_BUILD="x xvideo xshm"
GST_PLUGINS_BUILD_DIR="xvimage"

src_prepare() {
	gst-plugins10_system_link \
		gst-libs/gst/video:gstreamer-video \
		gst-libs/gst/interfaces:gstreamer-interfaces
}
