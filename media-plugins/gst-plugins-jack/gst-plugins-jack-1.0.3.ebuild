# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jack/gst-plugins-jack-1.0.3.ebuild,v 1.1 2012/12/03 23:46:20 eva Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPION="GStreamer source/sink to transfer audio data with JACK ports"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/jack-audio-connection-kit-0.99.10"
DEPEND="${RDEPEND}"
