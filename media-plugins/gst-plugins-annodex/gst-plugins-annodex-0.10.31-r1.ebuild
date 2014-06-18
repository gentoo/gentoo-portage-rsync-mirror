# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-annodex/gst-plugins-annodex-0.10.31-r1.ebuild,v 1.2 2014/06/18 20:01:59 mgorny Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer plugin for annodex stream manipulation"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.9.1-r4[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
