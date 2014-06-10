# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vpx/gst-plugins-vpx-1.2.4-r1.ebuild,v 1.1 2014/06/10 19:23:16 mgorny Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer decoder for vpx video format"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE=""

# VP9 is under experimental, do not enable it now
RDEPEND=">=media-libs/libvpx-1.3[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
