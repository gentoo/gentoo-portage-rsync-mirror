# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dts/gst-plugins-dts-0.10.22.ebuild,v 1.7 2012/12/02 18:39:18 eva Exp $

EAPI=4
GST_TARBALL_SUFFIX="bz2"

inherit gst-plugins-bad gst-plugins10

DESCRIPTION="GStreamer plugin for MPEG-1/2 video encoding"
KEYWORDS="amd64 hppa x86 ~amd64-fbsd"
IUSE="+orc"

RDEPEND="media-libs/libdca
	>=media-libs/gstreamer-0.10.33:0.10
	>=media-libs/gst-plugins-base-0.10.33:0.10
	orc? ( >=dev-lang/orc-0.4.11 )"
DEPEND="${RDEPEND}"

src_configure() {
	gst-plugins10_src_configure $(use_enable orc)
}
