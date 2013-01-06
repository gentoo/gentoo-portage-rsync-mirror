# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vp8/gst-plugins-vp8-0.10.23.ebuild,v 1.2 2012/12/02 19:58:28 eva Exp $

EAPI="5"

inherit gst-plugins-bad gst-plugins10

DESCRIPTION="GStreamer decoder for vpx video format"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd"
IUSE=""

RDEPEND="media-libs/libvpx"
DEPEND="${RDEPEND}"

src_prepare() {
	gst-plugins10_find_plugin_dir
	# gstbasevideo has no .pc
	sed -e "s:\$(top_builddir)/gst-libs/gst/video/.*\.la:-lgstbasevideo-${SLOT}:" \
		-i Makefile.am Makefile.in || die
}
