# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dts/gst-plugins-dts-0.10.23.ebuild,v 1.7 2013/02/07 13:10:50 ago Exp $

EAPI="5"

inherit gst-plugins-bad gst-plugins10

DESCRIPTION="GStreamer plugin for MPEG-1/2 video encoding"
KEYWORDS="amd64 ~arm hppa ~ppc ~ppc64 x86 ~amd64-fbsd"
IUSE="+orc"

RDEPEND="
	media-libs/libdca
	orc? ( >=dev-lang/orc-0.4.11 )
"
DEPEND="${RDEPEND}"

src_configure() {
	gst-plugins10_src_configure $(use_enable orc)
}
