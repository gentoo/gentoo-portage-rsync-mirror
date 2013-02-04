# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-assrender/gst-plugins-assrender-1.0.3.ebuild,v 1.7 2013/02/04 19:37:09 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for ASS/SSA rendering with effects support"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libass-0.9.4"
DEPEND="${RDEPEND}"
