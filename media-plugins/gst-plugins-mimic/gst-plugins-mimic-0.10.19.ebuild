# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mimic/gst-plugins-mimic-0.10.19.ebuild,v 1.10 2012/12/02 16:22:24 eva Exp $

EAPI="1"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for the MIMIC codec"

KEYWORDS="arm"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29:0.10
	>=media-libs/libmimic-1.0.4"
DEPEND="${RDEPEND}"
