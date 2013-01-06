# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.10.30.ebuild,v 1.9 2012/12/02 16:28:17 eva Exp $

EAPI="3"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for OSS (Open Sound System) support"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}
	virtual/os-headers"
