# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-1.2.4-r1.ebuild,v 1.6 2014/08/21 10:44:03 ago Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer plugin for OSS (Open Sound System) support"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd"
IUSE=""

RDEPEND=""
DEPEND="virtual/os-headers"
