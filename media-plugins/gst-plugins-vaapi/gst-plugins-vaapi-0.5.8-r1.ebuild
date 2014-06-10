# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vaapi/gst-plugins-vaapi-0.5.8-r1.ebuild,v 1.1 2014/06/10 19:19:37 mgorny Exp $

EAPI="5"
inherit eutils multilib-minimal

MY_PN="gstreamer-vaapi"
DESCRIPTION="Hardware accelerated video decoding through VA-API plugin"
HOMEPAGE="http://gitorious.org/vaapi/gstreamer-vaapi"
SRC_URI="http://www.freedesktop.org/software/vaapi/releases/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="1.0"
KEYWORDS="~amd64"
IUSE="+X opengl wayland"

RDEPEND="
	>=dev-libs/glib-2.28:2[${MULTILIB_USEDEP}]
	>=media-libs/gstreamer-1.2:1.0[${MULTILIB_USEDEP}]
	>=media-libs/gst-plugins-base-1.2:1.0[${MULTILIB_USEDEP}]
	>=media-libs/gst-plugins-bad-1.2:1.0[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXrandr[${MULTILIB_USEDEP}]
	>=x11-libs/libva-1.1.0[X?,opengl?,wayland?,${MULTILIB_USEDEP}]
	virtual/opengl[${MULTILIB_USEDEP}]
	virtual/udev[${MULTILIB_USEDEP}]
	wayland? ( >=dev-libs/wayland-1[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
	virtual/pkgconfig[${MULTILIB_USEDEP}]"

S="${WORKDIR}/${MY_PN}-${PV}"

# --disable-encoders as it needs hardmasked libva version
multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		--with-gstreamer-api=1.2 \
		--disable-encoders \
		--disable-static \
		--enable-drm \
		$(use_enable opengl glx) \
		$(use_enable wayland) \
		$(use_enable X x11)
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files --modules
}
