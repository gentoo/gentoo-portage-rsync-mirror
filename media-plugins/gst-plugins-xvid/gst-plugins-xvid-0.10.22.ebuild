# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvid/gst-plugins-xvid-0.10.22.ebuild,v 1.4 2012/12/02 16:43:31 eva Exp $

EAPI="1"

inherit gst-plugins-bad

KEYWORDS="amd64 x86"
IUSE=""
DESCRIPTION="GStreamer plugin for XviD (MPEG-4) video encoding/decoding support"

RDEPEND="media-libs/xvid
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"
