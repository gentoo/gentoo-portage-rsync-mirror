# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-0.10.19.ebuild,v 1.8 2013/02/04 10:03:12 ago Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libsidplay-1.3:1"
DEPEND="${RDEPEND}"
