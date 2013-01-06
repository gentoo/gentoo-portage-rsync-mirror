# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.35.ebuild,v 1.11 2012/12/02 18:24:33 eva Exp $

EAPI="3"

inherit gst-plugins-base gst-plugins10

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x64-macos"
IUSE=""

RDEPEND=">=media-libs/libogg-1.0"
DEPEND="${RDEPEND}"

src_prepare() {
	gst-plugins10_system_link \
		gst-libs/gst/riff:gstreamer-riff \
		gst-libs/gst/tag:gstreamer-tag
}
