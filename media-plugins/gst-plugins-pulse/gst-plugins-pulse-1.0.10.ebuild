# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pulse/gst-plugins-pulse-1.0.10.ebuild,v 1.1 2013/09/01 17:13:33 eva Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for the PulseAudio sound server"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/pulseaudio-1"
DEPEND="${RDEPEND}"
