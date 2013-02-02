# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vp8/gst-plugins-vp8-0.10.23-r1.ebuild,v 1.7 2013/02/02 22:56:24 ago Exp $

EAPI="5"

inherit eutils gst-plugins-bad gst-plugins10

DESCRIPTION="GStreamer decoder for vpx video format"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND="media-libs/libvpx"
DEPEND="${RDEPEND}"

src_prepare() {
	# Fix zero-bitrate vp8 encoding with libvpx-1.1, bug #435282
	epatch "${FILESDIR}/${PN}-0.10.23-libvpx-1.1.patch"

	gst-plugins10_find_plugin_dir
	# gstbasevideo has no .pc
	sed -e "s:\$(top_builddir)/gst-libs/gst/video/.*\.la:-lgstbasevideo-${SLOT}:" \
		-i Makefile.am Makefile.in || die
}
