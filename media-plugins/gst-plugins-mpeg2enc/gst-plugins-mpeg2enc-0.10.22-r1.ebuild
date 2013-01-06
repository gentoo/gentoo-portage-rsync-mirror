# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mpeg2enc/gst-plugins-mpeg2enc-0.10.22-r1.ebuild,v 1.2 2012/12/02 16:24:29 eva Exp $

EAPI=2

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for MPEG-1/2 video encoding"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-video/mjpegtools-1.9.0
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"

src_prepare() {
	# Upstream patch to build against mjpegtools 2.0
	epatch "${FILESDIR}/${P}-compile-fix.patch"
}
