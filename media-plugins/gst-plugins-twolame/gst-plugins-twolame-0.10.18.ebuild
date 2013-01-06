# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-twolame/gst-plugins-twolame-0.10.18.ebuild,v 1.8 2013/01/01 17:54:33 ago Exp $

EAPI="1"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~arm ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-sound/twolame-0.3.10
	>=media-libs/gstreamer-0.10.26:0.10
	>=media-libs/gst-plugins-base-0.10.26:0.10"
DEPEND="${RDEPEND}"
