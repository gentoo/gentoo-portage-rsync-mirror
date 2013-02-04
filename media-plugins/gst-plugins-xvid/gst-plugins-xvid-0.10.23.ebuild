# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvid/gst-plugins-xvid-0.10.23.ebuild,v 1.11 2013/02/04 19:38:57 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for XviD (MPEG-4) video encoding/decoding support"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="media-libs/xvid"
DEPEND="${RDEPEND}"
