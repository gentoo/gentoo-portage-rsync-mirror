# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-schroedinger/gst-plugins-schroedinger-0.10.22.ebuild,v 1.4 2012/12/02 19:57:33 eva Exp $

EAPI="2"

inherit gst-plugins-bad gst-plugins10

KEYWORDS="~amd64 ~x86"
IUSE=""

# Prefers schroedinger-1.0.9 to be able to post frame-stats messages,
# but at this time it is stuck in keywording due to dev-lang/orc issues
RDEPEND=">=media-libs/schroedinger-1.0.7-r2
	>=media-libs/gst-plugins-base-0.10.33:0.10
	>=media-libs/gst-plugins-bad-${PV}:0.10" # uses basevideo
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="schro"
GST_PLUGINS_BUILD_DIR="schroedinger"

src_prepare() {
	gst-plugins10_find_plugin_dir
	# gstbasevideo has no .pc
	sed -e "s:\$(top_builddir)/gst-libs/gst/video/.*\.la:-lgstbasevideo-${SLOT}:" \
		-i Makefile.am Makefile.in || die
}
