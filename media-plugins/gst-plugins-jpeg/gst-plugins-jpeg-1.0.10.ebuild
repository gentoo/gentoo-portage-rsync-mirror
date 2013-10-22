# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jpeg/gst-plugins-jpeg-1.0.10.ebuild,v 1.8 2013/10/22 07:20:57 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder for JPEG format"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/jpeg"
DEPEND="${RDEPEND}"
