# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-flac/gst-plugins-flac-0.10.30.ebuild,v 1.10 2012/12/02 16:11:38 eva Exp $

EAPI="3"

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder/tagger for FLAC"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/flac-1.1.4
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"
