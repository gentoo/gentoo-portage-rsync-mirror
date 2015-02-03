# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-schroedinger/gst-plugins-schroedinger-1.4.5.ebuild,v 1.1 2015/02/03 19:53:11 pacho Exp $

EAPI="5"
GST_ORG_MODULE=gst-plugins-bad

inherit gstreamer

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/schroedinger-1.0.11-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="schro"
GST_PLUGINS_BUILD_DIR="schroedinger"
