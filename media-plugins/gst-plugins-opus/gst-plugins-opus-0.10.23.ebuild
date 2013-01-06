# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-opus/gst-plugins-opus-0.10.23.ebuild,v 1.1 2012/12/09 18:21:52 tetromino Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for Opus audio codec support"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=media-libs/opus-0.9.4:="
RDEPEND="${COMMON_DEPEND}
	media-plugins/gst-plugins-ogg:${SLOT}"
DEPEND="${COMMON_DEPEND}"
