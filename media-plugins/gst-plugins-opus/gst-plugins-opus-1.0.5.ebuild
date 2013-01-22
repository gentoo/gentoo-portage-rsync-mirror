# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-opus/gst-plugins-opus-1.0.5.ebuild,v 1.1 2013/01/22 22:29:53 eva Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for Opus audio codec support"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

COMMON_DEPEND=">=media-libs/opus-0.9.4:="
RDEPEND="${COMMON_DEPEND}
	media-libs/gst-plugins-base:${SLOT}[ogg]"
DEPEND="${COMMON_DEPEND}"
