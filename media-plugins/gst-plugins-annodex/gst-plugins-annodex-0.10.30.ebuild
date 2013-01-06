# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-annodex/gst-plugins-annodex-0.10.30.ebuild,v 1.7 2012/12/02 15:55:40 eva Exp $

EAPI="3"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for annodex stream manipulation"

KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10
	>=dev-libs/libxml2-2.4.9"
DEPEND="${RDEPEND}"
