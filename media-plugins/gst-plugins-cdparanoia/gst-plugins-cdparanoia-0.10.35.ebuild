# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.35.ebuild,v 1.8 2012/12/02 18:23:05 eva Exp $

EAPI="3"

inherit gst-plugins-base gst-plugins10

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-sound/cdparanoia-3.10.2-r3"
DEPEND="${RDEPEND}"

src_prepare() {
	gst-plugins10_system_link \
		gst-libs/gst/audio:gstreamer-audio \
		gst-libs/gst/cdda:gstreamer-cdda
}
