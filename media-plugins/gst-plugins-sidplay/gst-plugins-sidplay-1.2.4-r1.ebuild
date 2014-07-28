# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-1.2.4-r1.ebuild,v 1.5 2014/07/28 13:47:53 ago Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-ugly
inherit gstreamer

KEYWORDS="~alpha amd64 ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libsidplay-1.36.59-r1:1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
