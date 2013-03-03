# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-gdkpixbuf/gst-plugins-gdkpixbuf-1.0.5.ebuild,v 1.11 2013/03/03 12:51:20 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPION="GdkPixbuf-based image decoder, overlay and sink"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gdk-pixbuf-2.8:2"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="gdk_pixbuf"
GST_PLUGINS_BUILD_DIR="gdk_pixbuf"
