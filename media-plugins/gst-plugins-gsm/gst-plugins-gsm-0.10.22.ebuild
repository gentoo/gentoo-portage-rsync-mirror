# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gsm/gst-plugins-gsm-0.10.22.ebuild,v 1.3 2012/12/02 16:14:47 eva Exp $

EAPI="1"

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""
DESCRIPTION="GStreamer plugin for GSM audio decoding/encoding"

RDEPEND="media-sound/gsm
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"
