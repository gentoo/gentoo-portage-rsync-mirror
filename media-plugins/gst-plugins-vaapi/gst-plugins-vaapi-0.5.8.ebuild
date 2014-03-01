# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vaapi/gst-plugins-vaapi-0.5.8.ebuild,v 1.1 2014/03/01 10:09:39 pacho Exp $

EAPI="5"
inherit eutils

MY_PN="gstreamer-vaapi"
DESCRIPTION="Hardware accelerated video decoding through VA-API plugin"
HOMEPAGE="http://gitorious.org/vaapi/gstreamer-vaapi"
SRC_URI="http://www.freedesktop.org/software/vaapi/releases/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="1.0"
KEYWORDS="~amd64"
IUSE="+X opengl wayland"

RDEPEND="
	>=dev-libs/glib-2.28:2
	>=media-libs/gstreamer-1.2:1.0
	>=media-libs/gst-plugins-base-1.2:1.0
	>=media-libs/gst-plugins-bad-1.2:1.0
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXrandr
	>=x11-libs/libva-1.1.0[X?,opengl?,wayland?]
	virtual/opengl
	virtual/udev
	wayland? ( >=dev-libs/wayland-1 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
	virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

# --disable-encoders as it needs hardmasked libva version
src_configure() {
	econf \
		--with-gstreamer-api=1.2 \
		--disable-encoders \
		--disable-static \
		--enable-drm \
		$(use_enable opengl glx) \
		$(use_enable wayland) \
		$(use_enable X x11)
}

src_install() {
	default
	prune_libtool_files --modules
}
