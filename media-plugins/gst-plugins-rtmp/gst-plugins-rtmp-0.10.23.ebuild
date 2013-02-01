# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-rtmp/gst-plugins-rtmp-0.10.23.ebuild,v 1.3 2013/02/01 12:37:00 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for supporting RTMP sources"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-video/rtmpdump"
DEPEND="${RDEPEND}"
