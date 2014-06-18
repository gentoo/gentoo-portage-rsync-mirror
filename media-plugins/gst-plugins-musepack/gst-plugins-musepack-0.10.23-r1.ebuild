# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-musepack/gst-plugins-musepack-0.10.23-r1.ebuild,v 1.2 2014/06/18 20:15:58 mgorny Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=media-sound/musepack-tools-465-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
