# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-jack/gst-plugins-jack-0.10.31.ebuild,v 1.13 2013/02/04 19:37:31 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPION="GStreamer source/sink to transfer audio data with JACK ports"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-sound/jack-audio-connection-kit-0.99.10"
DEPEND="${RDEPEND}"
