# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mplex/gst-plugins-mplex-1.2.3.ebuild,v 1.5 2014/04/18 13:57:17 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for MPEG/DVD/SVCD/VCD video/audio multiplexing"
KEYWORDS="alpha amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-video/mjpegtools-2"
DEPEND="${RDEPEND}"
