# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-assrender/gst-plugins-assrender-1.4.5.ebuild,v 1.6 2015/03/29 10:50:29 jer Exp $

EAPI="5"
GST_ORG_MODULE=gst-plugins-bad

inherit gstreamer

DESCRIPTION="GStreamer plugin for ASS/SSA rendering with effects support"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/libass-0.10.2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
