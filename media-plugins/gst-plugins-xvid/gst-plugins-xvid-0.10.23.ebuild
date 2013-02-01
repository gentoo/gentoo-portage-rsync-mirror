# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvid/gst-plugins-xvid-0.10.23.ebuild,v 1.7 2013/02/01 18:32:36 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for XviD (MPEG-4) video encoding/decoding support"
KEYWORDS="amd64 ~hppa ppc ppc64 x86"
IUSE=""

RDEPEND="media-libs/xvid"
DEPEND="${RDEPEND}"
