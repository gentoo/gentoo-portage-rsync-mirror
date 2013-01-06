# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-assrender/gst-plugins-assrender-0.10.22.ebuild,v 1.3 2012/12/02 15:54:48 eva Exp $

EAPI="3"

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"
IUSE=""
DESCRIPTION="GStreamer plugin for ASS/SSA rendering with effects support"

RDEPEND=">=media-libs/libass-0.9.4
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"
