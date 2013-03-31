# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvid/gst-plugins-xvid-0.10.23.ebuild,v 1.16 2013/03/31 17:31:56 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for XviD (MPEG-4) video encoding/decoding support"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/xvid"
DEPEND="${RDEPEND}"
