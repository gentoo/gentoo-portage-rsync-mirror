# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gdkpixbuf/gst-plugins-gdkpixbuf-1.2.4-r1.ebuild,v 1.11 2014/10/11 13:12:58 maekke Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPION="GdkPixbuf-based image decoder, overlay and sink"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gdk-pixbuf-2.30.7:2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="gdk_pixbuf"
GST_PLUGINS_BUILD_DIR="gdk_pixbuf"
