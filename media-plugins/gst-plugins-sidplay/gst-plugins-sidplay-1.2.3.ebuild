# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-sidplay/gst-plugins-sidplay-1.2.3.ebuild,v 1.6 2014/04/18 13:57:31 ago Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/libsidplay-1.3:1"
DEPEND="${RDEPEND}"
