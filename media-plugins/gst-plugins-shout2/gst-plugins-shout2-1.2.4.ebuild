# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-1.2.4.ebuild,v 1.1 2014/05/31 15:07:45 pacho Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to send data to an icecast server"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libshout-2"
DEPEND="${RDEPEND}"
