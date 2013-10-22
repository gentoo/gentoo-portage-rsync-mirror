# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-1.0.10.ebuild,v 1.10 2013/10/22 07:21:40 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x64-macos"
IUSE=""

# FIXME: automagic dependency on libsoup-gnome
RDEPEND=">=net-libs/libsoup-2.26.1"
DEPEND="${RDEPEND}"
