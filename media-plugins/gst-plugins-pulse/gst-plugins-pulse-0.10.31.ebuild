# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pulse/gst-plugins-pulse-0.10.31.ebuild,v 1.10 2013/02/07 13:26:37 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for the PulseAudio sound server"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~sh ~sparc x86"
IUSE=""

RDEPEND=">=media-sound/pulseaudio-0.98"
DEPEND="${RDEPEND}"
