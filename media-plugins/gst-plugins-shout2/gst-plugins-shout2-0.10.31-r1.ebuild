# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.10.31-r1.ebuild,v 1.5 2014/07/28 13:47:51 ago Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer plugin to send data to an icecast server"
KEYWORDS="~alpha amd64 ppc ~ppc64 ~sh x86"
IUSE=""

RDEPEND=">=media-libs/libshout-2.3.1-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
