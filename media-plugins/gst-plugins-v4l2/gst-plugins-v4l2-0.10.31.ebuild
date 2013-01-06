# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l2/gst-plugins-v4l2-0.10.31.ebuild,v 1.3 2012/12/03 23:57:46 eva Exp $

EAPI="5"

inherit eutils gst-plugins-good gst-plugins10

DESCRIPION="plugin to allow capture from video4linux2 devices"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="udev"

RDEPEND="
	media-libs/libv4l
	>=media-plugins/gst-plugins-xvideo-${PV}:${SLOT}
	udev? ( >=virtual/udev-143[gudev] )
"
DEPEND="${RDEPEND}
	virtual/os-headers"

GST_PLUGINS_BUILD="gst_v4l2"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.10.31-linux-headers-3.6.patch" #437012
}

src_configure() {
	gst-plugins10_src_configure \
		--with-libv4l2 \
		$(use_with udev gudev)
}
