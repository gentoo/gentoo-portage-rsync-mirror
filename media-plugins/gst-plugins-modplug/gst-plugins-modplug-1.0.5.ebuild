# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-1.0.5.ebuild,v 1.1 2013/01/22 22:28:24 eva Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/libmodplug"
DEPEND="${RDEPEND}"
