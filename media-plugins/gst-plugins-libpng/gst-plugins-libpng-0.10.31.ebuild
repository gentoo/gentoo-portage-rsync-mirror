# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.31.ebuild,v 1.7 2013/02/04 09:59:07 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder for PNG images"
KEYWORDS="alpha amd64 ~arm ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libpng-1.4"
DEPEND="${RDEPEND}"
