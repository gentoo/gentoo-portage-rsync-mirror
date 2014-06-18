# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gsm/gst-plugins-gsm-0.10.23-r1.ebuild,v 1.2 2014/06/18 20:06:44 mgorny Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

DESCRIPTION="GStreamer plugin for GSM audio decoding/encoding"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/gsm-1.0.13-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
