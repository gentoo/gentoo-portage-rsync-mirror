# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvdread/gst-plugins-dvdread-0.10.18.ebuild,v 1.9 2012/12/02 16:08:55 eva Exp $

EAPI="1"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/libdvdread
	>=media-libs/gstreamer-0.10.26:0.10
	>=media-libs/gst-plugins-base-0.10.26:0.10"
DEPEND="${RDEPEND}"
