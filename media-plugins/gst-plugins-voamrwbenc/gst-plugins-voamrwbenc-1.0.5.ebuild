# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-voamrwbenc/gst-plugins-voamrwbenc-1.0.5.ebuild,v 1.3 2013/02/21 16:55:30 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for encoding AMR-WB"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=media-libs/vo-amrwbenc-0.1"
DEPEND="${RDEPEND}"
