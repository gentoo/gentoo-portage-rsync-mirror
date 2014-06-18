# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pango/gst-plugins-pango-0.10.36-r1.ebuild,v 1.2 2014/06/18 20:17:49 mgorny Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-base
inherit gstreamer

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/pango-1.36.3[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	gstreamer_system_link \
		gst-libs/gst/video:gstreamer-video
}
