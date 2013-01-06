# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-assrender/gst-plugins-assrender-0.10.23.ebuild,v 1.1 2012/12/02 17:54:15 eva Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for ASS/SSA rendering with effects support"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libass-0.9.4"
DEPEND="${RDEPEND}"
