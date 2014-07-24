# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l2/gst-plugins-v4l2-0.10.31.ebuild,v 1.14 2014/07/24 18:50:51 ssuominen Exp $

EAPI="5"

inherit eutils gst-plugins-good gst-plugins10

DESCRIPION="plugin to allow capture from video4linux2 devices"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="udev"

RDEPEND="
	media-libs/libv4l
	>=media-plugins/gst-plugins-xvideo-${PV}:${SLOT}
	udev? ( virtual/libgudev:= )
"
DEPEND="${RDEPEND}
	virtual/os-headers"

GST_PLUGINS_BUILD="gst_v4l2"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.10.31-linux-headers-3.6.patch #437012
	epatch "${FILESDIR}"/${PN}-0.10.31-linux-headers-3.9.patch #468618
}

src_configure() {
	gst-plugins10_src_configure \
		--with-libv4l2 \
		$(use_with udev gudev)
}
