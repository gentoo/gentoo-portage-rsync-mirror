# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-voaacenc/gst-plugins-voaacenc-1.2.3.ebuild,v 1.1 2014/03/01 10:27:38 leio Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for encoding AAC"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/vo-aacenc-0.1"
DEPEND="${RDEPEND}"
