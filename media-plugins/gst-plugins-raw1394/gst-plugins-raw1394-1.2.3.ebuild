# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-raw1394/gst-plugins-raw1394-1.2.3.ebuild,v 1.3 2014/03/09 12:08:49 pacho Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to capture firewire video"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="
	>=media-libs/libiec61883-1
	>=sys-libs/libraw1394-2
	sys-libs/libavc1394
"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="dv1394"
GST_PLUGINS_BUILD_DIR="raw1394"
