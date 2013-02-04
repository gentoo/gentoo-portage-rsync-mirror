# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jpeg/gst-plugins-jpeg-0.10.31.ebuild,v 1.8 2013/02/04 09:57:28 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder for JPEG format"
KEYWORDS="alpha amd64 ~arm ~hppa ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="virtual/jpeg
	>=media-libs/gst-plugins-base-0.10.36:${SLOT}"
DEPEND="${RDEPEND}"
