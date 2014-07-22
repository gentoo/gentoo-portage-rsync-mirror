# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jpeg/gst-plugins-jpeg-0.10.31-r1.ebuild,v 1.3 2014/07/22 10:50:05 ago Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer encoder/decoder for JPEG format"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/jpeg-0-r2[${MULTILIB_USEDEP}]
	>=media-libs/gst-plugins-base-0.10.36:${SLOT}[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
