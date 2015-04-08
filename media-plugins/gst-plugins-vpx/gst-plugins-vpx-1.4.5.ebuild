# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vpx/gst-plugins-vpx-1.4.5.ebuild,v 1.6 2015/03/29 11:10:26 jer Exp $

EAPI="5"
GST_ORG_MODULE=gst-plugins-good

inherit gstreamer

DESCRIPTION="GStreamer decoder for vpx video format"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

# VP9 is under experimental, do not enable it now
RDEPEND=">=media-libs/libvpx-1.3.0[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
