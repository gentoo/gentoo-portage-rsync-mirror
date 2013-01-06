# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.10.18.ebuild,v 1.10 2013/01/01 17:53:25 ago Exp $

EAPI="1"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=media-sound/lame-3.95
	>=media-libs/gstreamer-0.10.26:0.10
	>=media-libs/gst-plugins-base-0.10.26:0.10"
DEPEND="${RDEPEND}"
