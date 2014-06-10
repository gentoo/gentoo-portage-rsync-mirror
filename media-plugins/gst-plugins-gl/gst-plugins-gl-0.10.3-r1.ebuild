# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gl/gst-plugins-gl-0.10.3-r1.ebuild,v 1.1 2014/06/10 19:00:37 mgorny Exp $

EAPI="5"
GST_TARBALL_SUFFIX="gz"

inherit gstreamer

DESCRIPTION="GStreamer OpenGL plugins"
HOMEPAGE="http://gstreamer.freedesktop.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libvisual"

RDEPEND="
	>=media-libs/glew-1.5[${MULTILIB_USEDEP}]
	>=media-libs/libpng-1.4:0=[${MULTILIB_USEDEP}]
	>=media-libs/gstreamer-0.10.35:0.10[${MULTILIB_USEDEP}]
	>=media-libs/gst-plugins-base-0.10.35:0.10[${MULTILIB_USEDEP}]
	virtual/glu[${MULTILIB_USEDEP}]
	virtual/opengl[${MULTILIB_USEDEP}]
	x11-libs/libSM[${MULTILIB_USEDEP}]
	libvisual? ( >=media-libs/libvisual-0.4[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.3
"

# FIXME: some deal with gst-plugin-scanner
RESTRICT=test

# FIXME: add support for libvisual
multilib_src_configure() {
	gstreamer_multilib_src_configure \
		--disable-examples \
		--disable-static \
		--disable-valgrind \
		$(use_enable libvisual)

	if multilib_is_native_abi; then
		local d
		for d in libs plugins; do
			ln -s "${S}"/docs/${d}/html docs/${d}/html || die
		done
	fi
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files --modules
}
