# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-0.10.30.ebuild,v 1.10 2012/12/02 16:36:10 eva Exp $

EAPI="3"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x64-macos"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10
	>=net-libs/libsoup-2.26:2.4"
DEPEND="${RDEPEND}"
