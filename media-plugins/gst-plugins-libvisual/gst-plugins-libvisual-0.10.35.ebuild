# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libvisual/gst-plugins-libvisual-0.10.35.ebuild,v 1.9 2012/12/02 18:23:58 eva Exp $

EAPI="3"

inherit gst-plugins-base gst-plugins10

KEYWORDS="amd64 hppa ppc ppc64 x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/libvisual-0.4
	>=media-plugins/libvisual-plugins-0.4"
DEPEND="${RDEPEND}"

src_prepare() {
	gst-plugins10_system_link \
		gst-libs/gst/audio:gstreamer-audio \
		gst-libs/gst/video:gstreamer-video
}
