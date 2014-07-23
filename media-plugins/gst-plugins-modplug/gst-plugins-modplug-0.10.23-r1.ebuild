# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-0.10.23-r1.ebuild,v 1.4 2014/07/23 15:21:43 ago Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/libmodplug-0.8.8.4-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
