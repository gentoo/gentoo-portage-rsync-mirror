# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-raw1394/gst-plugins-raw1394-0.10.30.ebuild,v 1.5 2012/12/02 16:30:58 eva Exp $

EAPI="3"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to capture firewire video"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/libiec61883-1.0.0
	>=sys-libs/libraw1394-2.0.0
	sys-libs/libavc1394
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="dv1394"
GST_PLUGINS_BUILD_DIR="raw1394"
