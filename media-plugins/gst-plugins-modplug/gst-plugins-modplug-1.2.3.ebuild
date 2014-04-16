# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-1.2.3.ebuild,v 1.5 2014/04/16 07:48:30 ago Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="media-libs/libmodplug"
DEPEND="${RDEPEND}"
