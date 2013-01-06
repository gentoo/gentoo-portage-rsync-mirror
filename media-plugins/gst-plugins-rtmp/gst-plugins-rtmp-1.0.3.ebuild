# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-rtmp/gst-plugins-rtmp-1.0.3.ebuild,v 1.1 2012/12/05 22:56:05 eva Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for supporting RTMP sources"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-video/rtmpdump"
DEPEND="${RDEPEND}"
