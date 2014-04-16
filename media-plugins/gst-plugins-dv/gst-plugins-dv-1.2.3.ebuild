# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-1.2.3.ebuild,v 1.6 2014/04/16 07:48:00 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to demux and decode DV"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/libdv-0.100"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="libdv"
