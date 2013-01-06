# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ximagesrc/gst-plugins-ximagesrc-0.10.30.ebuild,v 1.5 2012/12/02 16:42:57 eva Exp $

EAPI="3"

inherit gst-plugins-good

KEYWORDS="amd64 ppc ppc64 x86"

IUSE=""
RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10
	x11-libs/libX11
	x11-libs/libXdamage
	x11-libs/libXfixes"
DEPEND="${RDEPEND}
	x11-proto/xproto"

# xshm is a compile time option of ximage
GST_PLUGINS_BUILD="x xshm"
GST_PLUGINS_BUILD_DIR="ximage"
