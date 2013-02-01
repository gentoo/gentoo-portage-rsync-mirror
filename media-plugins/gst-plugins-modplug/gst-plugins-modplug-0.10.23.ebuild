# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-0.10.23.ebuild,v 1.3 2013/02/01 12:33:48 ago Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="media-libs/libmodplug"
DEPEND="${RDEPEND}"
