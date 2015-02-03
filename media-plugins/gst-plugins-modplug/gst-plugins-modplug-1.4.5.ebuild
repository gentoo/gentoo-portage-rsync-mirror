# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-1.4.5.ebuild,v 1.1 2015/02/03 19:31:36 pacho Exp $

EAPI="5"
GST_ORG_MODULE=gst-plugins-bad

inherit gstreamer

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libmodplug-0.8.8.4-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
