# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-voaacenc/gst-plugins-voaacenc-1.0.10.ebuild,v 1.2 2013/10/10 11:56:50 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for encoding AAC"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/vo-aacenc-0.1"
DEPEND="${RDEPEND}"
