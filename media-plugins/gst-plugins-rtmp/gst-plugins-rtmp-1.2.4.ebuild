# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-rtmp/gst-plugins-rtmp-1.2.4.ebuild,v 1.1 2014/05/31 15:05:13 pacho Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for supporting RTMP sources"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-video/rtmpdump"
DEPEND="${RDEPEND}"
