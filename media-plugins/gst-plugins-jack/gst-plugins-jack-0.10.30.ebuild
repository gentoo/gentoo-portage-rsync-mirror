# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jack/gst-plugins-jack-0.10.30.ebuild,v 1.4 2012/12/02 16:15:44 eva Exp $

EAPI="3"

inherit gst-plugins-good

DESCRIPION="GStreamer source/sink to transfer audio data with JACK ports"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10
	>=media-sound/jack-audio-connection-kit-0.99.10"
DEPEND="${RDEPEND}"
