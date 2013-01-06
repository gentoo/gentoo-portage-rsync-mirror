# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-0.10.18.ebuild,v 1.6 2012/12/02 16:34:51 eva Exp $

EAPI="1"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="=media-libs/libsidplay-1.3*
	 >=media-libs/gstreamer-0.10.26:0.10
	 >=media-libs/gst-plugins-base-0.10.26:0.10"
DEPEND="${RDEPEND}"
