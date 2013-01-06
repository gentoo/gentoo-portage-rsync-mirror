# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-schroedinger/gst-plugins-schroedinger-0.10.23.ebuild,v 1.2 2012/12/02 19:57:33 eva Exp $

EAPI="5"

inherit gst-plugins-bad gst-plugins10

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/schroedinger-1.0.9"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="schro"
GST_PLUGINS_BUILD_DIR="schroedinger"

src_prepare() {
	gst-plugins10_find_plugin_dir
	# gstbasevideo has no .pc
	sed -e "s:\$(top_builddir)/gst-libs/gst/video/.*\.la:-lgstbasevideo-${SLOT}:" \
		-i Makefile.am Makefile.in || die
}
