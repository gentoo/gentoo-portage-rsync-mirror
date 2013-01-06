# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mpeg2enc/gst-plugins-mpeg2enc-1.0.3.ebuild,v 1.1 2012/12/05 22:53:49 eva Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for MPEG-1/2 video encoding"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-video/mjpegtools-2"
DEPEND="${RDEPEND}"
