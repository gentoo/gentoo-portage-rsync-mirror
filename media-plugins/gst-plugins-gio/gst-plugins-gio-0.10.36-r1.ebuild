# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gio/gst-plugins-gio-0.10.36-r1.ebuild,v 1.2 2014/06/18 20:07:42 mgorny Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-base
inherit gstreamer

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.38.2-r1:2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
