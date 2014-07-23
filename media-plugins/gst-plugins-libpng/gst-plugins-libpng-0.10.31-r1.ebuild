# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libpng/gst-plugins-libpng-0.10.31-r1.ebuild,v 1.4 2014/07/23 15:21:33 ago Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer encoder/decoder for PNG images"
KEYWORDS="~alpha amd64 ~arm ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libpng-1.6.10:0=[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
