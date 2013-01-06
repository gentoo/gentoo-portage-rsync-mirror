# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvid/gst-plugins-xvid-0.10.23.ebuild,v 1.1 2012/12/02 18:05:03 eva Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for XviD (MPEG-4) video encoding/decoding support"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/xvid"
DEPEND="${RDEPEND}"
