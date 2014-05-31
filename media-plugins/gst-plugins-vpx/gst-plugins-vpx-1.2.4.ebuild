# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vpx/gst-plugins-vpx-1.2.4.ebuild,v 1.2 2014/05/31 17:26:59 pacho Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer decoder for vpx video format"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE=""

# VP9 is under experimental, do not enable it now
RDEPEND=">=media-libs/libvpx-1.3"
DEPEND="${RDEPEND}"
