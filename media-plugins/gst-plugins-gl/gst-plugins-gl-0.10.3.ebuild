# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gl/gst-plugins-gl-0.10.3.ebuild,v 1.2 2013/04/06 03:14:27 tetromino Exp $

EAPI="5"
GST_TARBALL_SUFFIX="gz"

inherit gst-plugins10

DESCRIPTION="GStreamer OpenGL plugins"
HOMEPAGE="http://gstreamer.freedesktop.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libvisual"

RDEPEND="
	>=media-libs/glew-1.5
	>=media-libs/libpng-1.4:0=
	>=media-libs/gstreamer-0.10.35:0.10
	>=media-libs/gst-plugins-base-0.10.35:0.10
	virtual/glu
	virtual/opengl
	libvisual? ( >=media-libs/libvisual-0.4 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.3
"

# FIXME: add support for libvisual
src_configure() {
	gst-plugins10_src_configure \
		--disable-examples \
		--disable-static \
		--disable-valgrind \
		$(use_enable libvisual)
}

src_compile() {
	default
}

src_install() {
	default
	prune_libtool_files --modules
}
