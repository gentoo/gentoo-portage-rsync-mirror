# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-flac/gst-plugins-flac-0.10.31-r1.ebuild,v 1.1 2014/06/10 18:59:07 mgorny Exp $

EAPI="5"

GST_ORG_MODULE="gst-plugins-good"
inherit gstreamer

DESCRIPTION="GStreamer encoder/decoder/tagger for FLAC"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/flac-1.1.4[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
