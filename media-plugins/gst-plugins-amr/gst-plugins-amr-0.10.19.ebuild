# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-amr/gst-plugins-amr-0.10.19.ebuild,v 1.2 2013/10/10 11:54:30 ago Exp $

EAPI="5"

inherit eutils gst-plugins-ugly

DESCRIPTION="GStreamer plugin for AMRNB/AMRWB codec"
HOMEPAGE="http://gstreamer.freedesktop.org/"

LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="media-libs/opencore-amr"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="amrnb amrwb"
GST_PLUGINS_BUILD_DIR="amrnb amrwbdec"

src_prepare() {
	# Fix build with current opencore-amr
	epatch "${FILESDIR}"/${P}-headers-location.patch
}
